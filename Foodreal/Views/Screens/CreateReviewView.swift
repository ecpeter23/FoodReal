//
//  CreateReviewView.swift
//  Foodreal
//
//  Created by Eli Peter on 11/14/23.
//

import SwiftUI

struct CreateReviewView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack{
            Text("Create new Review")
        }
        .padding(.bottom, 10)
        Button("Pop") {
            coordinator.pop()
        }
        .navigationTitle("Create new Review")
    }
}

#Preview {
    CreateReviewView()
}
