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
    var colors: [UIColor]
    
    init(name: String, emoji: [String], colors: [UIColor] ) {
        self.emoji = emoji
        self.colors = colors
        self.name = emoji[0]+name.capitalized+emoji[1]
    }
}
