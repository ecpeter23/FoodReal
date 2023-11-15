//
//  SettingsView.swift
//  Foodreal
//
//  Created by Eli Peter on 11/14/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {        
        VStack{
            Text("Settings")
        }
        .padding(.bottom, 10)
        Button("Push Account") {
            coordinator.push(.Account)
        }
        Button("Push About") {
            coordinator.push(.About)
        }
        Button("Push Privacy and Terms") {
            coordinator.push(.PrivacyAndTerms)
        }
        .padding(.bottom, 10)
        Button("Pop") {
            coordinator.pop()
        }
        .navigationTitle("Settings")
    }
    
}
    

#Preview {
    SettingsView()
}
