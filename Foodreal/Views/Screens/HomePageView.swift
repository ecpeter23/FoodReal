//
//  HomePageView.swift
//  Foodreal
//
//  Created by Eli Peter on 11/14/23.
//

import SwiftUI

struct HomePageView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var userAuth: UserAuthModel
    @State private var showDropdown = false

    
    var body: some View {
        // Sudo Code:
        // If account == nil:
        //     push to login
        // Settings Sudo Code:
        // Drop down menu:
        //     If user selects any item: (DONE)
        //         Push to that item
        //     If user clicks anywhere else: (DONE)
        //         Go back to home
        
        ZStack {
            VStack{
                // HOMESCREEN CODE HERE
                
                
                VStack{
                    Text("Home Page")
                }
                .padding(.bottom, 10)
                Button("Push Login Page") {
                    coordinator.push(.Login)
                }
                Button("Push Food Item") {
                    coordinator.push(.Food)
                }
                .padding(.bottom, 10)
                
                Button("Present Example Sheet") {
                    coordinator.present(sheet: .ExampleSheet)
                }
                Button("Present Example FullScreenCover") {
                    coordinator.present(fullScreenCover: .ExampleFullScreen)
                }
                .navigationTitle("Home Page")
                .navigationBarHidden(true)
            }
            
            
            // Semi-transparent overlay
            if showDropdown {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showDropdown = false
                        }
                    }
            }
            
            // Main button and dropdown menu aligned to the top leading
            VStack(alignment: .leading, spacing: 10) {
                Button(action: {
                    withAnimation {
                        showDropdown.toggle()
                    }
                }) {
                    Image(systemName: showDropdown ? "xmark" : "line.3.horizontal")
                        .rotationEffect(.degrees(showDropdown ? 90 : 0))
                }
                .buttonStyle(RoundButtonStyle(foregroundColor: .black, backgroundColor: .white))
                
                if showDropdown {
                    // Dropdown buttons
                    DropdownButton(title: "Account", url:  userAuth.profilePicUrl) {
                        showDropdown.toggle()
                        coordinator.push(.Account)
                    }
                    DropdownButton(title: "About", icon: "questionmark.circle.fill") {
                        showDropdown.toggle()
                        coordinator.push(.About)
                    }
                    DropdownButton(title: "Privacy & Terms", icon: "lock.shield.fill") {
                        showDropdown.toggle()
                        coordinator.push(.PrivacyAndTerms)
                    }
                }
            }
            .padding(.top, 0) // Adjust this value as needed
            .padding(.leading, 16) // Adjust this value as needed
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Ensure the VStack aligns to the top leading
        }
    }
}




#Preview {
    HomePageView()
}
