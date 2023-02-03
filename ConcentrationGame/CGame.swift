//
//  CGame.swift
//  ConcentrationGame
//
//  Created by Quasar on 26.01.2023.
//

import Foundation

struct ConcentrationGame {
    
    private(set) var cards = [Card]()
    private var SpottedCard = [Card]()
    
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return  cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "ConcentrationGame.init(\(numberOfPairsOfCards): must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        var lastCardIndex = cards.count;
        
        while lastCardIndex > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(lastCardIndex)))
            lastCardIndex -= 1
            
            cards.swapAt(randomIndex, lastCardIndex)
        }
    }
    
    mutating func resetGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            
        }
        SpottedCard.removeAll()
        
    }
    
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingIndex =  indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex] == cards[index] {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                SpottedCard += [cards[index], cards[matchingIndex]]
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
    extension Collection {
        var oneAndOnly: Element? {
            return count == 1 ? first : nil
        }
    }

