//
//  LogPixelEventView.swift
//  EnvoyExamples
//
//  Created by Bianca Felecan on 05.01.2024.
//

import SwiftUI
import EnvoySDK

struct LogPixelEventView: View {
    
    @State private var success: Bool?
    @State private var error: String?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Log pixel event")
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
            self.logPixelEvent()
        }
    }
    
    private func logPixelEvent() {
        let request = LogPixelEventRequest(
            event: .appDownloaded, userId: "1",
            sharerUserId: "12345", shareLinkHash: "",
            extra: LogPixelEventRequest.Extra(campaign: "Campaign", userType: "user type"))
        
        Envoy.shared.logPixelEvent(request: request) { response, error in
            self.success = error == nil
            self.error = error?.message
        }
    }
}

#Preview {
    LogPixelEventView()
}
