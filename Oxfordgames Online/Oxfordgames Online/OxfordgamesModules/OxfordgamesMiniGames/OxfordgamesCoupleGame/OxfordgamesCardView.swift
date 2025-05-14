import SwiftUI

struct OxfordgamesCardView: View {
    let card: OxfordgamesCard

    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                Image(card.type)
                    .resizable()
                    .scaledToFit()
                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 200:120)
            } else {
                Image(.cardBackOxfordgames)
                    .resizable()
                    .scaledToFit()
                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 200:120)
            }
        }
    }
}

#Preview {
    OxfordgamesCardView(card: OxfordgamesCard(type: "cardFace1SG"))
}
