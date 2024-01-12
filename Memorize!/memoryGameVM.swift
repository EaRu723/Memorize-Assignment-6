//
//  memoryGameVM.swift
//  Memorize!
//
//  Created by Andrea Russo on 11/16/23.
//

import Foundation
import SwiftUI

class memoryGameVM: ObservableObject {
    @Published private var model: MemoryGameModel<String>
    let chosenTheme: Theme

    
    // factory method to crate a new memory game
    static func createMemoryGame(of theme: Theme) -> MemoryGameModel<String> {
        let emojis = theme.emojis.map { String($0) }.shuffled()
        
        return MemoryGameModel(numberOfPairsOfCards: theme.numberOfPairs) { index in
        emojis[index]
        }
    }
    
//    private static func createMemoryGame(with emojis: [String], numberOfPairs: Int) -> MemoryGameModel<String> {
//        return MemoryGameModel(numberOfPairsOfCards: numberOfPairs) {
//            pairIndex in if pairIndex < emojis.count {
//                return emojis[pairIndex]
//            }
//            else{ return "🤯⁉️"
//            }
//        }
//    }
    
    init(theme: Theme) {
        chosenTheme = theme
        model = memoryGameVM.createMemoryGame(of: chosenTheme)
    }
    // computed property to access the cards in the model
    var cards: Array<MemoryGameModel<String>.Card> {
        return model.cards
    }
    
    var currentScore: Int{
        model.score
    }
    // method to shuffle the cards
    func shuffle() {
        model.shuffle()
    }
    
    // method to choose a card
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
    func startNewGame(){
        model = memoryGameVM.createMemoryGame(of: chosenTheme)
    }
}
