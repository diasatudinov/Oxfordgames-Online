import SwiftUI

struct OxfordgamesMemorizationView: View {
    @StateObject var user = OxfordgamesUser.shared
    @Environment(\.presentationMode) var presentationMode
    
    let cardImages = ["card1Oxfordgames", "card2Oxfordgames", "card3Oxfordgames", "card4Oxfordgames", "card5Oxfordgames", "card6Oxfordgames", "card7Oxfordgames", "card8Oxfordgames"]
    let sequenceLength = 3
    
    @State private var sequence: [Int] = []
    @State private var currentStep: Int? = nil
    @State private var gamePhase: GamePhase = .showing
    @State private var userInputIndex = 0
    @State private var feedback: String? = nil
    
    enum GamePhase {
        case showing
        case userTurn
        case finished
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
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
                                    startGame()
                                    
                                } label: {
                                    Image(.restartBtnOxfordgames)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 100:50)
                                }
                            }
                            Spacer()
                            
                            OxfordgamesCoinBg()
                        }.padding([.horizontal, .top])
                    }
                }
                
                Spacer()
                
                if gamePhase == .showing {
                    // Full-screen reveal of each card in sequence
                    if let idx = currentStep {
                        MemorizationCardView(imageName: cardImages[idx])
                            .frame(height: OxfordgamesDeviceManager.shared.deviceType == .pad ? 600:300)
                            .padding()
                            .transition(.opacity)
                    }
                } else {
                    // Grid for user interaction
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                        ForEach(0..<cardImages.count, id: \.self) { index in
                            MemorizationCardView(imageName: cardImages[index])
                                .onTapGesture {
                                    handleTap(on: index)
                                }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                
            }
            
            if gamePhase == .finished {
                
                if userInputIndex >= sequenceLength {
                    ZStack {
                        Image(.winBgOxfordgames)
                            .resizable()
                            .scaledToFit()
                        
                        VStack {
                            
                            Spacer()
                            
                            Button {
                                startGame()
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
                                startGame()
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
        .background(
            ZStack {
                Image(.appBgOxfordgames)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .onAppear {
            startGame()
        }
        .animation(.easeInOut, value: currentStep)
    }
    
    private var headerText: String {
        switch gamePhase {
        case .showing:
            return "Watch the sequence..."
        case .userTurn:
            return "Your turn: repeat the sequence"
        case .finished:
            return feedback ?? ""
        }
    }
    
    private func startGame() {
        sequence = Array(0..<cardImages.count).shuffled().prefix(sequenceLength).map { $0 }
        userInputIndex = 0
        feedback = nil
        gamePhase = .showing
        currentStep = nil
        
        Task {
            await revealSequence()
        }
    }
    
    @MainActor
    private func revealSequence() async {
        for idx in sequence {
            currentStep = idx
            try? await Task.sleep(nanoseconds: 800_000_000)
            currentStep = nil
            try? await Task.sleep(nanoseconds: 300_000_000)
        }
        gamePhase = .userTurn
    }
    
    private func handleTap(on index: Int) {
        guard gamePhase == .userTurn else { return }
        if index == sequence[userInputIndex] {
            userInputIndex += 1
            if userInputIndex >= sequenceLength {
                feedback = "Correct! You win!"
                user.updateUserMoney(for: 30)
                gamePhase = .finished
                
            }
        } else {
            feedback = "Wrong! Try again."
            gamePhase = .finished
        }
    }
}

struct MemorizationCardView: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .cornerRadius(8)
            .shadow(radius: 4)
    }
}

#Preview {
    OxfordgamesMemorizationView()
}
