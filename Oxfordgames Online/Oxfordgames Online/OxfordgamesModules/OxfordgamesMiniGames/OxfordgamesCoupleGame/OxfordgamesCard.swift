import Foundation

struct OxfordgamesCard: Identifiable {
    let id = UUID()
    let type: String
    var isFaceUp = false
    var isMatched = false
}
