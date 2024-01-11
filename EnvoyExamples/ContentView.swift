//
//  ContentView.swift
//  EnvoyExamples
//
//  Created by Bianca Felecan on 05.01.2024.
//

import SwiftUI
import EnvoySDK

struct ContentView: View {
    
    let navigation: UINavigationController
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    Text("Envoy Examples")
                        .font(.system(size: 30))
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 40)
                
                Button {
                    self.createLink()
                } label: {
                    Text("Create link")
                }
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                )
                
                Button {
                    self.claimUserReward()
                } label: {
                    Text("Claim user reward")
                }
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                )
                
                Button {
                    self.getUserCurrentRewards()
                } label: {
                    Text("Get user current rewards")
                }
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                )
                
                Button {
                    self.getUserRewards()
                } label: {
                    Text("Get user rewards")
                }
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                )
                
                Button {
                    self.logAppDownloadedEvent()
                } label: {
                    Text("Log app downloaded event")
                }
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                )
                
                Button {
                    self.logAccountCreatedEvent()
                } label: {
                    Text("Log account created event")
                }
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                )
                
                Button {
                    self.logTrialActivatedEvent()
                } label: {
                    Text("Log trial activated event")
                }
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                )
                
                Button {
                    self.logPaymentSuccessEvent()
                } label: {
                    Text("Log payment success event")
                }
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                )
                
                Button {
                    self.getUserQuota()
                } label: {
                    Text("Get user quota")
                }
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                )
                
                Spacer()
            }
            .padding(20)
        }
    }
    
    private func createLink() {
        let request = self.mockedLinkRequest()
        Envoy.shared.pushShareGift(
            in: self.navigation, request: request)
    }
    
    private func claimUserReward() {
        self.navigation.pushViewController(UIHostingController(
            rootView: ClaimUserRewardView()), animated: true)
    }
    
    private func getUserRewards() {
        self.navigation.pushViewController(UIHostingController(
            rootView: GetUserRewardsView()), animated: true)
    }
    
    private func getUserCurrentRewards() {
        self.navigation.pushViewController(UIHostingController(
            rootView: GetUserCurrentRewardsView()), animated: true)
    }
    
    private func logAppDownloadedEvent() {
        self.navigation.pushViewController(UIHostingController(
            rootView: LogPixelEventView(event: .appDownloaded)), animated: true)
    }
    
    private func logAccountCreatedEvent() {
        self.navigation.pushViewController(UIHostingController(
            rootView: LogPixelEventView(event: .accountCreated)), animated: true)
    }
    
    private func logTrialActivatedEvent() {
        self.navigation.pushViewController(UIHostingController(
            rootView: LogPixelEventView(event: .trialActivated)), animated: true)
    }
    
    private func logPaymentSuccessEvent() {
        self.navigation.pushViewController(UIHostingController(
            rootView: LogPixelEventView(event: .paymentSuccess)), animated: true)
    }
    
    private func getUserQuota() {
        self.navigation.pushViewController(UIHostingController(
            rootView: GetUserQuotaView()), animated: true)
    }
    
    private func mockedLinkRequest() -> CreateLinkRequest {
        let common = CreateLinkRequest.Common(
            source: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            sourceIsRedirect: false,
            poster: "https://picsum.photos/id/237/200/300")
        
        let contentSetting = CreateLinkRequest.ContentSetting(
            contentType: "VIDEO",
            contentName: "Content name",
            contentDescription: "content description",
            common: common,
            videoOrientation: .vertical,
            isSandbox: true)
        
        return CreateLinkRequest(autoplay: false,
                                 contentSetting: contentSetting,
                                 sharerId: "336",
                                 isSandbox: true)
    }
}

#Preview {
    ContentView(navigation: UINavigationController())
}
