import SwiftUI
import AVFoundation

struct OxfordgamesCoupleGameView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var user = OxfordgamesUser.shared
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var cards: [OxfordgamesCard] = []
    @State private var selectedCards: [OxfordgamesCard] = []
    @State private var message: String = "Find all matching cards!"
    @State private var gameEnded: Bool = false
    @State private var isWin: Bool = false
    @State private var pauseShow: Bool = false
    private let cardTypes = ["cardFace1Oxfordgames", "cardFace2Oxfordgames", "cardFace3Oxfordgames", "cardFace4Oxfordgames", "cardFace5Oxfordgames", "cardFace6Oxfordgames"]
    private let gridSize = 4
    
    @State private var counter: Int = 0
    
    @State private var timeLeft: Int = 60
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            
                VStack {
                    HStack(alignment: .top) {
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                                
                            } label: {
                                Image(.backIconOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:50)
                            }
                            
                            Button {
                                setupGame()
                                
                            } label: {
                                Image(.restartBtnOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:50)
                            }
                        }
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            OxfordgamesCoinBg()
                            ZStack {
                                Image(.coupleTimerBgOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:50)
                                
                                Text("00:\(timeLeft)")
                                    .font(.system(size: OxfordgamesDeviceManager.shared.deviceType == .pad ? 48:24, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                        }
                    }.padding()
                    
                    Spacer()
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                        ForEach(cards) { card in
                            OxfordgamesCardView(card: card)
                                .onTapGesture {
                                    flipCard(card)
                                   
                                }
                                .opacity(card.isMatched ? 0.5 : 1.0)
                        }
                        
                    }
                    .frame(width: OxfordgamesDeviceManager.shared.deviceType == .pad ? 500:350)
                    Spacer()
                }
                .onAppear {
                    setupGame()
                }
            
            if gameEnded {
                if isWin {
                    ZStack {
                        Image(.winBgOxfordgames)
                            .resizable()
                            .scaledToFit()
                        
                        VStack {
                            
                            Spacer()
                            
                            Button {
                                setupGame()
                            } label: {
                                Image(.retryBtnOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 120:60)
                            }
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.menuBtnOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 120:60)
                            }
                            
                        }.padding(.bottom, OxfordgamesDeviceManager.shared.deviceType == .pad ? 100 : 50)
                    }.frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 700:350)
                } else {
                    ZStack {
                        Image(.loseBgOxfordgames)
                            .resizable()
                            .scaledToFit()
                        
                        VStack {
                            
                            
                            Button {
                                setupGame()
                            } label: {
                                Image(.retryBtnOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 120:60)
                            }
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.menuBtnOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 120:60)
                            }
                        }
                    }.frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 700:350)
                }
            }
           
            
        }
        .onReceive(timer) { _ in
            guard !gameEnded else { return }
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                gameEnded = true
                isWin = false
                timer.upstream.connect().cancel()
            }
        }
        .background(
            Image(.appBgOxfordgames)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        
        
    }
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if counter < 4 {
                withAnimation {
                    counter += 1
                }
            }
        }
    }
    
    private func setupGame() {
        selectedCards.removeAll()
        message = "Find all matching cards!"
        gameEnded = false
        timeLeft = 60
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        var gameCards = [OxfordgamesCard]()
        
        for type in cardTypes {
            gameCards.append(OxfordgamesCard(type: type))
            gameCards.append(OxfordgamesCard(type: type))
        }
                
        gameCards.shuffle()
        
        cards = Array(gameCards.prefix(gridSize * gridSize))
    }
    
    private func flipCard(_ card: OxfordgamesCard) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isFaceUp,
              !cards[index].isMatched,
              selectedCards.count < 2 else { return }
        
        cards[index].isFaceUp = true
        selectedCards.append(cards[index])
        
        if card.type == "cardSemaphore" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                resetAllCards()
            }
        } else if selectedCards.count == 2 {
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        let allMatch = selectedCards.allSatisfy { $0.type == selectedCards.first?.type }
        
        if allMatch {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isMatched = true
                }
            }
            message = "You found a match! Keep going!"
            isWin = true
        } else {
            message = "Not a match. Try again!"
            isWin = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for card in selectedCards {
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isFaceUp = false
                }
            }
            selectedCards.removeAll()
            
            if cards.allSatisfy({ $0.isMatched || $0.type == "cardSemaphore" }) {
                message = "Game Over! You found all matches!"
                gameEnded = true
                user.updateUserMoney(for: 30)
            }
        }
    }
    
    private func resetAllCards() {
        message = "Red semaphore! All cards reset!"
        for index in cards.indices {
            cards[index].isFaceUp = false
            
            cards[index].isMatched = false
            
        }
        selectedCards.removeAll()
    }
    
}

#Preview {
    OxfordgamesCoupleGameView()
}
