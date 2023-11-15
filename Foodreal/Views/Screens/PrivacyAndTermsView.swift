//
//  PrivacyAndTermsView.swift
//  Foodreal
//
//  Created by Eli Peter on 11/14/23.
//

import SwiftUI

struct PrivacyAndTermsView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack{
            Text("Privacy and Terms")
        }
        .padding(.bottom, 10)
        Button("Pop to Root") {
            coordinator.popToRoot()
        }
        .navigationTitle("Privacy and Terms")
    }
}

#Preview {
    PrivacyAndTermsView()
}
