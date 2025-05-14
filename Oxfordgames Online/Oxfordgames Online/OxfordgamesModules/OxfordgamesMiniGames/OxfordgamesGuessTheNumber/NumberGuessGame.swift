import SwiftUI

struct NumberGuessGame: View {
    @Environment(\.presentationMode) var presentationMode

    // MARK: - Game State
        @State private var target = Int.random(in: 100...999)
    @State private var guessDigits: [String] = []
    @State private var feedback: String = ""
    @State private var attempts = 0
    
    private let padNumbers = [1, 2, 3,
                              4, 5, 6,
                              7, 8, 9,
                              0]
    

        var body: some View {
            ZStack {
                VStack(spacing: SGDeviceManager.shared.deviceType == .pad ? 40:20) {
                    // Top bar
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
                    }.padding([.horizontal, .top])

                    
                    // Input slots
                    ZStack {
                        
                        Image(.guessNumBgOxfordgames)
                            .resizable()
                            .scaledToFit()
                        
                        Image(.numberBgMinigame)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 130:65)
                        
                        HStack(spacing: 8) {
                            ForEach(0..<3) { idx in
                                ZStack {
                                    
                                    Text( idx < guessDigits.count ? guessDigits[idx] : "" )
                                        .font(.system(size: 36, weight: .bold))
                                        .foregroundColor(.white)
                                }.frame(width: SGDeviceManager.shared.deviceType == .pad ? 150:50, height: SGDeviceManager.shared.deviceType == .pad ? 150:100)
                            }
                        }
                        .padding(.vertical)
                    }


                    

                    Spacer()
                }
                
                VStack {
                    Spacer()
                    // Number Pad
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
                    LazyVGrid(columns: columns, spacing: SGDeviceManager.shared.deviceType == .pad ? 24:12) {
                        ForEach(padNumbers, id: \ .self) { num in
                            Button(action: { numberPressed(num) }) {
                                ZStack {
                                    
                                    Text("\(num)")
                                        .font(.system(size: SGDeviceManager.shared.deviceType == .pad ? 96:48, weight: .bold))
                                        .foregroundColor(.white)
                                }.frame(width: SGDeviceManager.shared.deviceType == .pad ? 150:100, height: SGDeviceManager.shared.deviceType == .pad ? 150:100)
                                    .background {
                                        Rectangle()
                                            .foregroundStyle(.bgGray)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.bgYellow, lineWidth: 5)
                                                
                                            }
                                            
                                    }
                                    .cornerRadius(10)
                                
                            }
                            .disabled(guessDigits.count >= 3)
                        }
                    }.frame(width: SGDeviceManager.shared.deviceType == .pad ? 500:350)
                    .padding(.horizontal)
                }
                
                
                
                if !feedback.isEmpty {
                    Text(feedback)
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 10)
                        .shadow(radius: 2)
                    
                    ZStack {
                        
                        if Int(guessDigits.joined()) ?? 0 < target {
                            Image(.guessMoreOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 500:250)
                        } else if Int(guessDigits.joined()) ?? 0 > target{
                            Image(.guessLessOxfordgames)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 500:250)
                        } else {
                            
                            ZStack {
                                Image(.winBgOxfordgames)
                                    .resizable()
                                    .scaledToFit()
                                
                                VStack {
                                    
                                    Spacer()
                                    
                                    Button {
                                        resetGame()
                                    } label: {
                                        Image(.retryBtnOxfordgames)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 120:60)
                                    }
                                    
                                    Button {
                                        presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        Image(.menuBtnOxfordgames)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 120:60)
                                    }
                                    
                                }.padding(.bottom, SGDeviceManager.shared.deviceType == .pad ? 100 : 50)
                            }.frame(height: SGDeviceManager.shared.deviceType == .pad ? 700:350)
                            
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
        }

    // MARK: - Actions
    private func numberPressed(_ num: Int) {
        guard guessDigits.count < 3 else { return }
        guessDigits.append("\(num)")
        if guessDigits.count == 3 {
            evaluateGuess()
        }
    }

    private func evaluateGuess() {
        let guess = Int(guessDigits.joined()) ?? 0
        attempts += 1
        if guess < target {
            feedback = "Too low!"
        } else if guess > target {
            feedback = "Too high!"
        } else {
            feedback = "You got it in \(attempts) tries!"
            SGUser.shared.updateUserMoney(for: 20)
        }
        // Only reset if correct to allow victory state
        if feedback.starts(with: "You got it") {
            // Do nothing, user sees success
        } else {
            // Reset after delay for another attempt
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // clear digits but keep target and attempts
                guessDigits = []
                feedback = ""
            }
        }
    }

    private func resetGame() {
        target = Int.random(in: 100...999)
        guessDigits = []
        feedback = ""
        attempts = 0
    }
}

#Preview {
    NumberGuessGame()
}
