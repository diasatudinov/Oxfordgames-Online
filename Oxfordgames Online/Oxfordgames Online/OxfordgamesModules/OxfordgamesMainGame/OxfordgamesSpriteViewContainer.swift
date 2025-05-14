import SwiftUI
import SpriteKit


struct OxfordgamesSpriteViewContainer: UIViewRepresentable {
    @StateObject var user = OxfordgamesUser.shared
    var scene: OxfordgamesGameScene
    @Binding var isWin: Bool
    @Binding var score: Int
    var level: Int
    func makeUIView(context: Context) -> SKView {
        let skView = SKView(frame: UIScreen.main.bounds)
        skView.backgroundColor = .clear
        scene.scaleMode = .resizeFill
        scene.winHandle = {
            isWin = true
            user.updateUserMoney(for: 100)
        }
        scene.levelIndex = level
        scene.scoreHandle = {
            score += 100
        }
        skView.presentScene(scene)
        
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.frame = UIScreen.main.bounds
    }
}
