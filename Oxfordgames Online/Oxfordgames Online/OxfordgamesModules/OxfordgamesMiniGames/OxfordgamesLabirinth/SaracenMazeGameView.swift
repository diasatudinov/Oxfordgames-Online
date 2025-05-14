//
//  SaracenMazeGameView.swift
//  Oxfordgames Online
//
//  Created by Dias Atudinov on 14.05.2025.
//


import SwiftUI
import SpriteKit

struct SaracenMazeGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isWin = false
    @State private var gameScene: SaracenMazeScene = {
        let scene = SaracenMazeScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    @State private var powerUse = false
    
    var body: some View {
        ZStack {
            SaracenMazeViewContainer(scene: gameScene, isWin: $isWin)
                
            
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
                            gameScene.restartGame()
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
                
                VStack(spacing: 0) {
                    Button {
                        gameScene.moveUp()
                        
                    } label: {
                        Image(.controlArrowOxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                    }
                    HStack(spacing: SGDeviceManager.shared.deviceType == .pad ? 100:50) {
                        Button {
                            gameScene.moveLeft()
                        } label: {
                            Image(.controlArrowOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                                .rotationEffect(.degrees(90))
                                .scaleEffect(x: -1, y: 1)
                        }
                        
                        Button {
                            gameScene.moveRight()
                        } label: {
                            Image(.controlArrowOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                                .rotationEffect(.degrees(90))
                        }
                    }
                    
                    Button {
                        gameScene.moveDown()
                    } label: {
                        Image(.controlArrowOxfordgames)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                            .scaleEffect(x: 1, y: -1)
                    }
                }
                
            }
            
            if isWin {
                ZStack {
                    Image(.winBgOxfordgames)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        
                        Spacer()
                        
                        Button {
                            gameScene.restartGame()
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
                Image(.appBgOxfordgames)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
}

#Preview {
    SaracenMazeGameView()
}
