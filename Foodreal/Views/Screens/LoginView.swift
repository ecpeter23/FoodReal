//
//  LoginView.swift
//  Foodreal
//
//  Created by Eli Peter on 11/14/23.
//

import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var userAuth: UserAuthModel

    var body: some View {
        VStack{
            Text("Login")
        }
        .padding(.bottom, 10)
        
        // GOOGLE SIGN IN BUTTON
        Button(action: {
            userAuth.signIn()
        }) {
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45) // Circle slightly smaller than the button height
                    Image("google")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .padding(.leading, 2) // 2 pixels padding from the left edge
                Spacer()

                Text("Sign in with Google")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.trailing, 20) // Optional: Adjust text padding if needed
            }
            .frame(width: 240, height: 50)
            .background(.gray.opacity(0.15))
            .cornerRadius(25) // Rounded corners with radius half of the height
        }
        
        Button("Push Onboarding"){
            coordinator.push(.Onboarding)
        }
        .padding(.bottom, 10)
        Button("Pop to Root"){
            coordinator.popToRoot()
        }
        .navigationTitle("Login")
        .toolbar(.hidden) // Hides the arrow navigation in the top left corner
    }
}

#Preview {
    LoginView()
}
