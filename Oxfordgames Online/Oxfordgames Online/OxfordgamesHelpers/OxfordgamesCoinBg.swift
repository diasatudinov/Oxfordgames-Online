import SwiftUI

struct OxfordgamesCoinBg: View {
    @StateObject var user = OxfordgamesUser.shared
    var body: some View {
        ZStack {
            Image(.coinsViewBgOxfordgames)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: OxfordgamesDeviceManager.shared.deviceType == .pad ? 48:24, weight: .black))
                .foregroundStyle(.white)
                .textCase(.uppercase)
            
            
            
        }.frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:50)
        
    }
}

#Preview {
    OxfordgamesCoinBg()
}
