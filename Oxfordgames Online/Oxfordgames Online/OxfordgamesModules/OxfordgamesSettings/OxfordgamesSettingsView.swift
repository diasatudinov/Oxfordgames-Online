import SwiftUI

struct OxfordgamesSettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var settingsVM: OxfordgamesSettingsViewModel
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
                            .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 60:30)
                        
                        Button {
                            withAnimation {
                                settingsVM.soundEnabled.toggle()
                            }
                        } label: {
                            
                            Image(settingsVM.soundEnabled ? .onOxfordgames:.offOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 80:40)
                        }
                    }
                    
                    VStack {
                        Image(.languageTextOxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 60:30)
                        
                        
                        Image(.enImageOxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 64:32)
                    }
                    
                }
                
                
            }.frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 700:366)
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                        Spacer()
                       
                        OxfordgamesCoinBg()
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
    
}

#Preview {
    OxfordgamesSettingsView(settingsVM: OxfordgamesSettingsViewModel())
}
