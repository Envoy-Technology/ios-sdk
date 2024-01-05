//
//  ClaimUserRewardView.swift
//  EnvoyExamples
//
//  Created by Bianca Felecan on 05.01.2024.
//

import SwiftUI
import EnvoySDK

struct ClaimUserRewardView: View {
    
    @State private var success: Bool?
    @State private var error: String?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Claim user reward")
                    .font(.system(size: 30))
                Spacer()
            }
            
            if success == true {
                Text("Success!")
            } else if let error = error {
                Text("Error: \(error)")
            }
            
            Spacer()
        }
        .padding(20)
        .onAppear {
            self.claimUserReward()
        }
    }
    
    private func claimUserReward() {
        let request = ClaimUserRewardRequest(userId: "1",
                                             paypalReceiver: "bianca@wolfpack-digital.com")
        Envoy.shared.claimUserReward(
            request: request) { response, error in
                self.success = error == nil
                self.error = error?.message
            }
    }
}

#Preview {
    ClaimUserRewardView()
}
