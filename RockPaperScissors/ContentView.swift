//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by FABRICIO ALVARENGA on 03/07/22.
//

import SwiftUI

struct ContentView: View {
    private let possibleChoices = ["✊", "✋", "✌️"]
    
    @State private var appChoice = "✊"
    @State private var playerHaveToWin = Bool.random()
    @State private var score = 0
    @State private var numberOfMoves = 0
    @State private var showingGameOver = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .padding()
                        .foregroundColor(.blue)
                    
                    VStack {
                        Text("App choice")
                            .font(.callout.smallCaps().bold())
                            .padding()
                        
                        Text(appChoice)
                            .font(.system(size: 50).bold())
                            .padding()
                        
                        Text("You have to \(playerHaveToWin ? "Win" : "Lose or Draw")")
                            .font(.callout.bold())
                            .padding()
                    }
                    .foregroundColor(.white)
                }
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .padding()
                        .foregroundColor(.purple)
                    
                    VStack {
                        Text("Make your choice")
                            .font(.callout.smallCaps().bold())
                        
                        HStack {
                            ForEach(possibleChoices, id: \.self) { choice in
                                Button(choice) {
                                    verifyResult(with: choice)
                                }
                                .font(.system(size: 50))
                                .padding()
                            }
                        }
                        
                        Text("Score: \(score)")
                            .font(.largeTitle.bold())
                        
                    }
                    .foregroundColor(.white)
                }
                
                Spacer()
            }
            .navigationTitle("Rock, Paper, Scissors")
            .alert("Game Over", isPresented: $showingGameOver) {
                Button("OK") {
                    appChoice = possibleChoices[Int.random(in: 0...2)]
                    playerHaveToWin = Bool.random()
                    score = 0
                    numberOfMoves = 0
                }
            }
        }
    }
    
    func verifyResult(with playerChoice: String) {
        if playerHaveToWin {
            if (appChoice == "✊" && playerChoice == "✋") ||
                (appChoice == "✋" && playerChoice == "✌️") ||
                (appChoice == "✌️" && playerChoice == "✊") {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if (appChoice == "✊" && (playerChoice == "✊" || playerChoice == "✌️")) ||
                (appChoice == "✋" && (playerChoice == "✋" || playerChoice == "✊")) ||
                (appChoice == "✌️" && (playerChoice == "✌️" || playerChoice == "✋")) {
                score += 1
            } else {
                score -= 1
            }
        }
        
        numberOfMoves += 1
        
        if numberOfMoves == 10 {
            showingGameOver = true
            return
        }

        playerHaveToWin.toggle()
        appChoice = possibleChoices[Int.random(in: 0...2)]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
