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
    @State private var response: UserCurrentRewardsResponse?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Get user current rewards")
                    .font(.system(size: 30))
                Spacer()
            }
            
            if let response = response {
                VStack {
                    Text("Earnable left: \(response.earnableLeft)")
                    Text("Earned this period: \(response.earnedThisPeriod)")
                        .padding(.bottom, 20)
                    
                    Text("Event count")
                        .fontWeight(.bold)
                    Text("Completed: \(response.eventCount.completed)")
                    Text("Left to reward: \(response.eventCount.leftToReward)")
                    Text("Percentage done: \(response.eventCount.percentageDone)%")
                }
            } else if let error = error {
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
        Envoy.shared.getUserCurrentRewards(userId: "412") { response, error in
            self.error = error?.message
            self.response = response
        }
    }
}

#Preview {
    GetUserCurrentRewardsView()
}
