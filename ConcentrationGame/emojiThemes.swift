//
//  emojiThemes.swift
//  ConcentrationGame
//
//  Created by Quasar on 01.02.2023.
//

import Foundation
import UIKit

struct ThemeModel {
    var emoji: [String]
    var name: String
    
    init(name: String, emoji: [String] ) {
        self.emoji = emoji
        self.name = emoji[0]+name.capitalized+emoji[1]
    }
}
