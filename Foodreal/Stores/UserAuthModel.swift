//
//  UserAuthModel.swift
//  Foodreal
//
//  Created by Eli Peter on 11/14/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

class UserAuthModel: ObservableObject {
    
    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoggedIn: Bool = true
    @Published var newUser: Bool = true
    
    
    init() {
        restorePreviousSignIn()
        updateUserInfo()
    }
    
    func updateSignInStatus(isSignedIn: Bool) {
        DispatchQueue.main.async {
            self.isLoggedIn = isSignedIn
        }
    }
    
    func updateUserStatus(isNewUser: Bool) {
        DispatchQueue.main.async {
            self.newUser = isNewUser
        }
        
    }
    
    private func restorePreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            guard let self = self else { return }

            if let error = error {
                self.errorMessage = "Error during sign-in restoration: \(error.localizedDescription)"
            } else {
                self.updateUserInfo()
            }
        }
    }
    
    private func updateUserInfo() {
        
        guard let user = GIDSignIn.sharedInstance.currentUser else {
            updateSignInStatus(isSignedIn: false)
            self.givenName = "Not Logged In"
            self.profilePicUrl = ""
            return
        }
        
        updateSignInStatus(isSignedIn: true)
        self.givenName = user.profile?.givenName ?? ""
        self.profilePicUrl = user.profile?.imageURL(withDimension: 100)?.absoluteString ?? ""
    }
    
    func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { [weak self] user, error in
            guard let self = self else { return }

            if let error = error {
                self.errorMessage = "Sign-in error: \(error.localizedDescription)"
                return
            }

            guard let user = user?.user, let idToken = user.idToken else {
                self.errorMessage = "Failed to retrieve authentication token"
                return
            }
            
            let accessToken = user.accessToken

            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            self.firebaseSignIn(credential: credential)
            updateUserInfo()
        }
    }
    
    private func firebaseSignIn(credential: AuthCredential) {
        var isNewUser = true
        Auth.auth().signIn(with: credential) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                self.errorMessage = "Firebase sign-in error: \(error.localizedDescription)"
                return
            }
            
            isNewUser = ((result?.additionalUserInfo?.isNewUser) == true)
            self.updateUserStatus(isNewUser: isNewUser)
            
            
        }
    }

    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance.signOut()
            updateUserInfo()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
}

final class Application_utility {
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
