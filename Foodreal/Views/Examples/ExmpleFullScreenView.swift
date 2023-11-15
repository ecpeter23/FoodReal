//
//  ExmpleFullScreenView.swift
//  Foodreal
//
//  Created by Eli Peter on 11/14/23.
//

import SwiftUI

struct ExmpleFullScreenView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("Example FullScreenCover")
        }
        .padding(.bottom, 10)
        
        Button("Dismiss") {
            coordinator.dismissFullScreenCover()
        }
        .navigationTitle("FullScreen")
    }
}

#Preview {
    ExmpleFullScreenView()
}
