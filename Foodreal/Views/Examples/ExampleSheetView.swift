//
//  ExampleSheetView.swift
//  Foodreal
//
//  Created by Eli Peter on 11/14/23.
//

import SwiftUI

struct ExampleSheetView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("Example Sheet")
        }
        .padding(.bottom, 10)
        
        Button("Dismiss") {
            coordinator.dismissSheet()
        }
        .navigationTitle("Sheet")
    }
}

#Preview {
    ExampleSheetView()
}
