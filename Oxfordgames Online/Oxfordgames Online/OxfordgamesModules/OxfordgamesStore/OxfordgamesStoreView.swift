//
//  OxfordgamesStoreView.swift
//  Oxfordgames Online
//
//  Created by Dias Atudinov on 13.05.2025.
//

import SwiftUI

struct OxfordgamesStoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = SGUser.shared
    @State var section: StoreSection = .skin
    @ObservedObject var viewModel: StoreViewModelSG
    
    @State var skinIndex: Int = 0
    
    @State var backIndex: Int = 0
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
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                        }
                        Spacer()
                       
                        CoinBgSG()
                    }.padding([.horizontal, .top])
                }
                
                HStack {
                    Image(.skinsTextOxfordgames)
                        .resizable()
                        .scaledToFit()
                        .frame(height: SGDeviceManager.shared.deviceType == .pad ? 80:41)
                        .offset(y: section == .skin ? 20:0)
                        .onTapGesture {
                            withAnimation {
                                section = .skin
                            }
                        }
                    Image(.locationsTextOxfordgames)
                        .resizable()
                        .scaledToFit()
                        .frame(height: SGDeviceManager.shared.deviceType == .pad ? 80:41)
                        .offset(y: section == .backgrounds ? 20:0)
                        .onTapGesture {
                            withAnimation {
                                section = .backgrounds
                            }
                        }
                }.padding(.bottom, 40)
                
                if section == .skin {
                    ZStack {
                        storeItem(item: viewModel.shopTeamItems.filter({ $0.section == .skin })[skinIndex])
                        
                        HStack {
                            Button {
                                prevItem()
                            } label: {
                                Image(.backIconOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                                
                                
                            }
                            
                            Spacer()
                            Button {
                                nextItem()
                            } label: {
                                Image(.backIconOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                                    .scaleEffect(x: -1)
                                
                            }
                        }.frame(width: SGDeviceManager.shared.deviceType == .pad ? 700:350)
                    }
                } else {
                    
                    ZStack {
                        storeItem(item: viewModel.shopTeamItems.filter({ $0.section == .backgrounds })[backIndex])
                        
                        HStack {
                            Button {
                                prevItem()
                            } label: {
                                Image(.backIconOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                                
                                
                            }
                            
                            Spacer()
                            Button {
                                nextItem()
                            } label: {
                                Image(.backIconOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                                    .scaleEffect(x: -1)
                                
                            }
                        }.frame(width: SGDeviceManager.shared.deviceType == .pad ? 700:350)
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
    }
    
    @ViewBuilder func storeItem(item: Item) -> some View {
        
            VStack {
                
                Image(item.name)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                
                
                Image(item.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 660:330)
                
                
                Button {
                    if item.section == .skin {
                        if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            viewModel.currentPersonItem = item
                        } else {
                            if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                                
                                if user.money >= item.price {
                                    user.minusUserMoney(for: item.price)
                                    viewModel.boughtItems.append(item)
                                }
                            }
                        }
                    } else {
                        if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            viewModel.currentBgItem = item
                        } else {
                            if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                                
                                if user.money >= item.price {
                                    user.minusUserMoney(for: item.price)
                                    viewModel.boughtItems.append(item)
                                }
                            }
                        }
                    }
                } label: {
                    if item.section == .skin {
                        if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            VStack {
                                ZStack {
                                    Image(.selectTextOxfordgames)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                                    if let currentItem = viewModel.currentPersonItem, currentItem.name == item.name {
                                        Image(.selectedTextOxfordgames)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                                    }
                                    
                                }
                            }
                        } else {
                            
                            
                            Image(user.money >= item.price ? .priceBtnOxfordgames: .priceBtnOffOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                            
                            
                            
                        }
                    } else {
                        if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            VStack {
                                ZStack {
                                    Image(.selectTextOxfordgames)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                                    if let currentItem = viewModel.currentBgItem, currentItem.name == item.name {
                                        Image(.selectedTextOxfordgames)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                                    }
                                    
                                }
                            }
                        } else {
                            VStack {
                                ZStack {
                                    Image(user.money >= item.price ? .priceBtnOxfordgames: .priceBtnOffOxfordgames)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                                    
                                    
                                }
                            }
                        }
                    }
                }
            }
    }
    
    func prevItem() {
        if section == .skin {
            if skinIndex > 0 {
                skinIndex -= 1
            }
        } else {
            if backIndex > 0 {
                backIndex -= 1
            }
        }
        
    }
    
    func nextItem() {
        
        if section == .skin {
            if skinIndex < viewModel.shopTeamItems.filter({ $0.section == .skin }).count - 1 {
                skinIndex += 1
            }
        } else {
            if backIndex < viewModel.shopTeamItems.filter({ $0.section == .backgrounds }).count - 1 {
                backIndex += 1
            }
        }
        
        
    }
}

#Preview {
    OxfordgamesStoreView(viewModel: StoreViewModelSG())
}
