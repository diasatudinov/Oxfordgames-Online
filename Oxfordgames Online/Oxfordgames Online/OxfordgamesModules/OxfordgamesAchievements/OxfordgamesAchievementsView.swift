import SwiftUI

struct OxfordgamesAchievementsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: OxfordgamesAchievementsViewModel

    @State var index = 0
    
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
                
                Image(.achievementsTextOxfordgames)
                    .resizable()
                    .scaledToFit()
                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 180:90)
                
                ZStack {
                    
                    achievementItem(item: viewModel.achievements[index])
                        .onTapGesture {
                            viewModel.achieveToggle(viewModel.achievements[index])
                        }
                    HStack {
                        Button {
                            prevItem()
                        } label: {
                            Image(.backIconOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:50)
                            
                            
                        }
                        
                        Spacer()
                        Button {
                            nextItem()
                        } label: {
                            Image(.backIconOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:50)
                                .scaleEffect(x: -1)
                            
                        }
                    }.frame(width: OxfordgamesDeviceManager.shared.deviceType == .pad ? 700:350)
                        .offset(y: OxfordgamesDeviceManager.shared.deviceType == .pad ? -200:-100)
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
    
    @ViewBuilder func achievementItem(item: OxfordgamesAchievement) -> some View {
        VStack {
            Image(item.title)
                .resizable()
                .scaledToFit()
                .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 180:90)
            
            ZStack {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                
                if !item.isAchieved  {
                    Circle()
                        .foregroundStyle(.black.opacity(0.9))
                }
                    
            }.frame(width: OxfordgamesDeviceManager.shared.deviceType == .pad ? 400:200, height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 400:200)
            
            Image(item.subtitle)
                .resizable()
                .scaledToFit()
                .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 120:60)
            Spacer()
            if item.isAchieved {
                Image(.receivedTextOxfordgames)
                    .resizable()
                    .scaledToFit()
                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 180:90)
            } else {
                Image(.receivedTextOxfordgames)
                    .resizable()
                    .scaledToFit()
                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 180:90)
                    .opacity(0)
            }
        }
    }
    
    func prevItem() {
        if index > 0 {
            index -= 1
        }
    }
    
    func nextItem() {
        if index < viewModel.achievements.count - 1 {
            index += 1
        }
    }
}

#Preview {
    OxfordgamesAchievementsView(viewModel: OxfordgamesAchievementsViewModel())
}
