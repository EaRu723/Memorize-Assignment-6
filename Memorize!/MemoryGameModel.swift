//
//  MemoryGameModel.swift
//  Memorize!
//
//  Created by Andrea Russo on 11/16/23.
//

import Foundation

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    var score = 0 // initialize score as 0
    
    // initialize a new memory game with a specific number of cards
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        // populate the deck with pairs of cards
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
    }
    
    // gets index of face up card or returns nil if 0 or more than 1 are face up. Turns all cards face down except at retreived index
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    // function to choose a card and check match with current face up card
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        //match
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2 //award 2 points for match
                    }
                    //mismatch
                    else {
                        if cards[chosenIndex].isSeen {
                            score -= 1 //penalize 1 point for mismatch when card has been seen
                        }
                        if cards[potentialMatchIndex].isSeen {
                            score -= 1 //penalize 1 point for mismatch when second card is seen
                        }
                    }
                    cards[chosenIndex].isSeen = true
                    cards[potentialMatchIndex].isSeen = true
                }
                else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    // shuffle the cards
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    // defines single card
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        let content: CardContent
        
        var id: String
        var debugDescription : String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "") "
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
