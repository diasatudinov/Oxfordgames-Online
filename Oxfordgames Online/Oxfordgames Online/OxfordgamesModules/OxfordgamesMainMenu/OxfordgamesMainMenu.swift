import SwiftUI

struct OxfordgamesMainMenu: View {
    @State private var showGame = false
    @State private var showShop = false
    @State private var showAchievement = false
    @State private var showMiniGames = false
    @State private var showSettings = false
    
    @StateObject var achievementVM = OxfordgamesAchievementsViewModel()
    @StateObject var settingsVM = OxfordgamesSettingsViewModel()
    @StateObject var shopVM = OxfordgamesStoreViewModel()
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 15) {
                HStack(alignment: .top) {
                    
                    
                    Button {
                        showSettings = true
                    } label: {
                        Image(.settingsIconOxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:50)
                    }
                    
                    Spacer()
                    
                    OxfordgamesCoinBg()
                    
                    
                }
                
                Image(.logoOxfordgames)
                    .resizable()
                    .scaledToFit()
                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 400:224)
            
                
                Button {
                    showGame = true
                } label: {
                    Image(.playIconOxfordgames)
                        .resizable()
                        .scaledToFit()
                        .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 140:90)
                }
                
                Button {
                    showMiniGames = true
                } label: {
                    Image(.miniGamesIconOxfordgames)
                        .resizable()
                        .scaledToFit()
                        .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 140:90)
                }
                
                Button {
                    showAchievement = true
                } label: {
                    Image(.achievementsIconOxfordgames)
                        .resizable()
                        .scaledToFit()
                        .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 140:90)
                }
                
                Button {
                    showShop = true
                } label: {
                    Image(.storeIconOxfordgames)
                        .resizable()
                        .scaledToFit()
                        .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 140:90)
                }
                
                Spacer()
                ZStack {
                    HStack {
                        
                    }
                    
                    HStack(alignment: .bottom) {
                        
                        
                        Spacer()
                        
                        
                    }
                }
            }.padding()
                .ignoresSafeArea(edges: .bottom)
            
        }
        .background(
            ZStack {
                Image(.appBgOxfordgames)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $showGame) {
            OxfordgamesChooseLevelView(shopVM: shopVM)
        }
        .fullScreenCover(isPresented: $showMiniGames) {
            OxfordgamesMiniGamesView()
        }
        .fullScreenCover(isPresented: $showAchievement) {
            OxfordgamesAchievementsView(viewModel: achievementVM)
        }
        .fullScreenCover(isPresented: $showShop) {
            OxfordgamesStoreView(viewModel: shopVM)
        }
        .fullScreenCover(isPresented: $showSettings) {
            OxfordgamesSettingsView(settingsVM: settingsVM)
        }
        
        
        
        
    }
    
}
#Preview {
    OxfordgamesMainMenu()
}
