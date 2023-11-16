//
//  memoryGameVM.swift
//  Memorize!
//
//  Created by Andrea Russo on 11/16/23.
//

import Foundation
import SwiftUI

class memoryGameVM: ObservableObject {
    // structure to hold theme properties
    struct Theme {
        var name: String
        var emojis: [String]
        var numberOfPairs: Int
        var color: Color
    }
    
    // enum of cases for different theme variables
    enum GameTheme: String, CaseIterable{
        case flag, animal, food, red, orange, purple
        
        var theme: Theme {
            switch self {
            case .flag:
                return Theme(name: "Flags", emojis: ["🇺🇸","🇩🇿","🇩🇰","🇩🇪","🇷🇴","🇮🇹","🇮🇱","🇯🇲","🇮🇩","🇳🇬","🇲🇽","🇯🇵","🇮🇳","🇰🇷","🇬🇭","🇭🇷", "🇨🇺", "🇨🇦"], numberOfPairs: 18, color: .blue)
            case .animal:
                return Theme(name: "Animals", emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐸","🐵", "🐥", "🐙"], numberOfPairs: 18, color: .green)
            case .food:
                return Theme(name: "Foods", emojis: ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍","🥥", "🥑", "🥕"], numberOfPairs: 18, color: .yellow)
            case .red:
                return Theme(name: "Red", emojis: ["🉐","㊙️","㊗️","🈴","🈵","🈹","🈹","🈲","🅰️","🅱️","🆎","🆑","🅾️","🆘","❌","🛑", "📛", "💯"], numberOfPairs: 18, color: .red)
            case .orange:
                return Theme(name: "Orange", emojis: ["🉑","☢️","☣️","📴","📳","🈶","🈚️","🈸","🈺","🈷️","✴️","🆚"], numberOfPairs: 12, color: .orange)
            case .purple:
                return Theme(name: "Purple", emojis: ["💟","☮️","✝️","☪️","🕉️","☸️","🪯","✡️","🔯","🕎","☯️","☦️","🛐","⛎","♈️","♉️", "♊️", "♋️"], numberOfPairs: 18, color: .purple)
            }
        }
    }
    
    // factory method to crate a new memory game
    private static func createMemoryGame(with emojis: [String], numberOfPairs: Int) -> MemoryGameModel<String> {
        return MemoryGameModel(numberOfPairsOfCards: numberOfPairs) {
            pairIndex in if pairIndex < emojis.count {
                return emojis[pairIndex]
            }
            else{ return "🤯⁉️"
            }
        }
    }
    
    // memory game model marked as published to update views as they change
    @Published private var model: MemoryGameModel<String>
    
    var currentTheme: Theme
    
    init (theme: GameTheme) {
        let selectedTheme = theme.theme
        self.currentTheme = selectedTheme
        self.model = memoryGameVM.createMemoryGame(with: selectedTheme.emojis, numberOfPairs: selectedTheme.numberOfPairs)
        
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
        let allThemes = GameTheme.allCases
        let randomTheme = allThemes.randomElement() ?? .flag
        
        let selectedTheme = randomTheme.theme
        self.currentTheme = selectedTheme
        self.model = memoryGameVM.createMemoryGame(with: selectedTheme.emojis, numberOfPairs: selectedTheme.numberOfPairs)
        model.shuffle()
    }
}
