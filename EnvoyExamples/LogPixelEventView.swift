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
    
    @State var event: PixelEvent
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Log pixel event: \(event.rawValue)")
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
            event: event)
        
        Envoy.shared.logPixelEvent(request: request) { response, error in
            self.success = error == nil
            self.error = error?.message
        }
    }
}

#Preview {
    LogPixelEventView(event: .appDownloaded)
}
