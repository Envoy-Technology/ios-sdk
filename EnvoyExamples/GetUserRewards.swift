//
//  GetUserRewards.swift
//  EnvoyExamples
//
//  Created by Bianca Felecan on 05.01.2024.
//

import SwiftUI
import EnvoySDK

struct GetUserRewardsView: View {
    
    @State private var error: String?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Get user rewards")
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
            self.getUserRewards()
        }
    }
    
    private func getUserRewards() {
        Envoy.shared.getUserRewards(userId: "1") { response, error in
            self.error = error?.message
        }
    }
}

#Preview {
    GetUserRewardsView()
}
