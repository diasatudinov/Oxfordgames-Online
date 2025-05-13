//
//  OxfordgamesSettingsView.swift
//  Oxfordgames Online
//
//  Created by Dias Atudinov on 13.05.2025.
//

import SwiftUI
import StoreKit

struct OxfordgamesSettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var settingsVM: SettingsViewModelSG
    var body: some View {
        ZStack {
            
            ZStack {
                Image(.settingsBgOxfordgames)
                    .resizable()
                    .scaledToFit()
                VStack(spacing: 10) {
                    
                    
                    
                    VStack {
                        Image(.soundTextOxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 60:30)
                        
                        Button {
                            withAnimation {
                                settingsVM.soundEnabled.toggle()
                            }
                        } label: {
                            
                            Image(settingsVM.soundEnabled ? .onOxfordgames:.offOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 80:40)
                        }
                    }
                    
                    VStack {
                        Image(.languageTextOxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 60:30)
                        
                        
                        Image(.enImageOxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 64:32)
                    }
                    
                }
                
                
            }.frame(height: SGDeviceManager.shared.deviceType == .pad ? 700:366)
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                        Spacer()
                       
                        CoinBgSG()
                    }.padding([.horizontal, .top])
                }
                Spacer()
            }
        }.background(
            ZStack {
                Image(.appBgOxfordgames)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
    
    func rateUs() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    OxfordgamesSettingsView(settingsVM: SettingsViewModelSG())
}
