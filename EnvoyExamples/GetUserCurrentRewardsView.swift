//
//  GetUserCurrentRewardsView.swift
//  EnvoyExamples
//
//  Created by Bianca Felecan on 05.01.2024.
//

import SwiftUI
import EnvoySDK

struct GetUserCurrentRewardsView: View {
    
    @State private var error: String?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Get user current rewards")
                    .font(.system(size: 30))
                Spacer()
            }
            
            if let error = error {
                Text("Error: \(error)")
            }
            
            Spacer()
        }
        .padding(20)
        .onAppear {
            self.getUserCurrentRewards()
        }
    }
    
    private func getUserCurrentRewards() {
        Envoy.shared.getUserCurrentRewards(userId: "1") { response, error in
            self.error = error?.message
        }
    }
}

#Preview {
    GetUserCurrentRewardsView()
}
