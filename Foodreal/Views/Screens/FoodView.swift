//
//  FoodView.swift
//  Foodreal
//
//  Created by Eli Peter on 11/14/23.
//

import SwiftUI

struct FoodView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        // Sudo Code:
        // If user creates new review:
        //     Push to Create Review
        // (Maybe?) If user clicks back button (differnt from arrow):
        //     Pop to home
        
        VStack{
            Text("Food Item")
        }
        .padding(.bottom, 10)
        Button("Push Create Review") {
            coordinator.push(.CreateReview)
        }
        .padding(.bottom, 10)
        Button("Pop") {
            coordinator.pop()
        }
        .navigationTitle("Food Item")
    }
}

#Preview {
    FoodView()
}
