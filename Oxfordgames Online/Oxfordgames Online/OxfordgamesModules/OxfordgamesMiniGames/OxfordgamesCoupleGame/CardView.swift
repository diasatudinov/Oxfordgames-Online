//
//  CardView.swift
//  Oxfordgames Online
//
//  Created by Dias Atudinov on 14.05.2025.
//


import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            if card.isFaceUp || card.isMatched {
                Image(card.type)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 200:120)
            } else {
                Image(.cardBackOxfordgames)
                    .resizable()
                    .scaledToFit()
                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 200:120)
            }
        }
    }
}

#Preview {
    CardView(card: Card(type: "cardFace1SG"))
}
