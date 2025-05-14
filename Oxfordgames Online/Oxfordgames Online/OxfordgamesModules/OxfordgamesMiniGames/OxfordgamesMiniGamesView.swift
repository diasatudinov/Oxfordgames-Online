import SwiftUI

struct OxfordgamesMiniGamesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var game1 = false
    @State private var game2 = false
    @State private var game3 = false
    @State private var game4 = false
    var body: some View {
        ZStack {
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
                
                VStack(spacing: 20) {
                    Button {
                        game1 = true
                    } label: {
                        Image(.gameText1Oxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game2 = true
                    } label: {
                        Image(.gameText2Oxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game3 = true
                    } label: {
                        Image(.gameText3Oxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
                    
                    Button {
                        game4 = true
                    } label: {
                        Image(.gameText4Oxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 180:90)
                          
                    }
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
        .fullScreenCover(isPresented: $game1) {
            
            OxfordgamesNumberGuessGame()
            
        }
        .fullScreenCover(isPresented: $game2) {
            OxfordgamesCoupleGameView()
        }
        .fullScreenCover(isPresented: $game3) {
            OxfordgamesMemorizationView()
        }
        .fullScreenCover(isPresented: $game4) {
            OxfordgamesMazeGameView()
        }
    }
}

#Preview {
    OxfordgamesMiniGamesView()
}
