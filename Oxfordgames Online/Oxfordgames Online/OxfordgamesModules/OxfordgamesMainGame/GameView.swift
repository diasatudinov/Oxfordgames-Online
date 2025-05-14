import SwiftUI
import SpriteKit

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
   
    @State var gameScene: GameScene = {
        let scene = GameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    @ObservedObject var shopVM: StoreViewModelSG
    @State private var powerUse = false
    @State private var isWin = false
    @State private var score = 0
    @State var level: Int
    var imagesForView: [String] = ["viewImage1Oxfordgames","viewImage2Oxfordgames", ""]
    var body: some View {
        ZStack {
            SpriteViewContainer(scene: gameScene, isWin: $isWin, score: $score, level: level)
                .ignoresSafeArea()
            
            VStack(spacing: SGDeviceManager.shared.deviceType == .pad ? 200:100) {
                HStack(spacing: SGDeviceManager.shared.deviceType == .pad ? 200:100) {
                    ZStack {
                        Image(.rectangleMainGameOxfordgames)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: SGDeviceManager.shared.deviceType == .pad ? 280:140,height: SGDeviceManager.shared.deviceType == .pad ? 400:200)
                    
                    ZStack {
                        Image(.rectangleMainGameOxfordgames)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: SGDeviceManager.shared.deviceType == .pad ? 280:140,height: SGDeviceManager.shared.deviceType == .pad ? 400:200)
                }
                
                HStack(spacing: SGDeviceManager.shared.deviceType == .pad ? 200:100) {
                    ZStack {
                        Image(.rectangleMainGameOxfordgames)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: SGDeviceManager.shared.deviceType == .pad ? 280: 140,height: SGDeviceManager.shared.deviceType == .pad ? 400:200)
                    
                    ZStack {
                        Image(.rectangleMainGameOxfordgames)
                            .resizable()
                            .scaledToFit()
                        
                        Image(imagesForView[Int.random(in: Range(0...imagesForView.count - 1))])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            
                        
                    }
                    .frame(width: SGDeviceManager.shared.deviceType == .pad ? 280:140,height: SGDeviceManager.shared.deviceType == .pad ? 400:200)
                }
            }
            
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
                        
                        Button {
                            gameScene.restartLevel()
                            isWin = false
                        } label: {
                            Image(.restartBtnOxfordgames)
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
            
            if isWin {
                ZStack {
                    Image(.winBgOxfordgames)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        
                        Spacer()
                        
                        Button {
                            gameScene.restartLevel()
                            isWin = false
                        } label: {
                            Image(.retryBtnOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 120:60)
                        }
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(.menuBtnOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 120:60)
                        }
                        
                    }.padding(.bottom, SGDeviceManager.shared.deviceType == .pad ? 100 : 50)
                }.frame(height: SGDeviceManager.shared.deviceType == .pad ? 700:350)
            }
            
        }.background(
            ZStack {
                if let item = shopVM.currentBgItem {
                    Image(item.image)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                }
            }
        )
    }
}

#Preview {
    GameView(shopVM: StoreViewModelSG(), level: 0)
}
