//
//  GetUserQuotaView.swift
//  EnvoyExamples
//
//  Created by Bianca Felecan on 05.01.2024.
//

import SwiftUI
import EnvoySDK

struct GetUserQuotaView: View {
    
    @State private var remainingQuota: Int?
    @State private var error: String?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Get user quota")
                    .font(.system(size: 30))
                Spacer()
            }
            
            if let remainingQuota = self.remainingQuota {
                Text("Remaining quota: \(remainingQuota)")
            } else if let error = error {
                Text("Error: \(error)")
            }
            
            Spacer()
        }
        .padding(20)
        .onAppear {
            self.getUserQuota()
        }
    }
    
    private func getUserQuota() {
        Envoy.shared.getUserRemainingQuota(userId: "336") { response, error in
            self.error = error?.message
            self.remainingQuota = response?.userRemainingQuota
        }
    }
}

#Preview {
    GetUserQuotaView()
}
