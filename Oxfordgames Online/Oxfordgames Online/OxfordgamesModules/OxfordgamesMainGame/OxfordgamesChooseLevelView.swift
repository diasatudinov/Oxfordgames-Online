import SwiftUI

struct OxfordgamesChooseLevelView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shopVM: StoreViewModelSG

    @State var openGame = false
    @State var selectedIndex = 0
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
                
                Image(.levelSelectTextOxfordgames)
                    .resizable()
                    .scaledToFit()
                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 180:90)
                
                ZStack {
                    Image(.zikzakOxfordgames)
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: -4) {
                        ForEach(Range(0...9)) { index in
                            ZStack {
                                Image(.levelNumBgOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:65)
                                
                                Text("\(index + 1)")
                                    .font(.system(size: OxfordgamesDeviceManager.shared.deviceType == .pad ? 80:40, weight: .bold))
                                    .foregroundStyle(.white)
                            }.offset(x: putXLevels(for: index))
                                .onTapGesture {
                                    selectedIndex = index
                                    DispatchQueue.main.async {
                                        openGame = true
                                    }
                                    
                                }
                        }
                    }
                }
                
            }
        }.background(
            ZStack {
                Image(.appBgOxfordgames)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $openGame) {
            GameView(shopVM: shopVM, level: selectedIndex)
        }
    }
    
    func putXLevels(for index: Int) -> CGFloat {
        switch index {
        case 0:
            return -80
        case 1:
            return 80
        case 2:
            return -80
        case 3:
            return 80
        case 4:
            return -80
        case 5:
            return 80
        case 6:
            return -80
        case 7:
            return 80
        case 8:
            return -80
        case 9:
            return 80
        default:
            return 0
        }
    }
}

#Preview {
    OxfordgamesChooseLevelView(shopVM: StoreViewModelSG())
}
