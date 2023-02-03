//
//  Card.swift
//  ConcentrationGame
//
//  Created by Quasar on 26.01.2023.
//

import Foundation

struct Card: Hashable {

    var isFaceUp = false
    var isMatched = false
    private var indentifier: Int
    
func hash(into hasher: inout Hasher) {
   hasher.combine(indentifier)
}
    
 

static func == (lhs: Card, rhs: Card) -> Bool {
   return lhs.indentifier == rhs.indentifier
}



private static var indentifierNumber = 0

private static func indentifierGenerator() -> Int {
   indentifierNumber += 1
   return indentifierNumber
}

init() {
   self.indentifier = Card.indentifierGenerator()
}
}
