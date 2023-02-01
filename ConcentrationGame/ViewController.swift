//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Quasar on 26.01.2023.
//

import UIKit

class ViewController: UIViewController {
 
    
    
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards )
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1 ) / 2
    }
    
    private func updateTouches() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.red
        ]
        let attributedString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
        touchLabel.attributedText = attributedString
    }
    
    private(set) var touches = 0 {
        didSet{
            updateTouches()
        }
    }
    
    private var emojiChoice = [String]()
    private var cardEmoji = [Card:String]()
    private var currentThemeIndex = 0
    
    
    
    private let themes = [
        ThemeModel(name: "Fruits", emoji : ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🫐","🍓","🍈","🍒","🍑","🥭","🍍","🥥","🥝"]),
        ThemeModel(name: "Faces", emoji: ["😀","😍","😴","😱","🤣","😂","😉","🙄","😬","🤨"]),
        ThemeModel(name: "Animal", emoji: ["🐶","🐱","🐼","🦊","🦁","🐯","🐨","🐮","🐷","🐵"]),
        ThemeModel(name: "Summer", emoji: ["🏄🏼‍♂️","🏊🏼‍♀️","☀️","🌈","🌼","🏖","⛱","🏝","🎣","🍦"]),
        ThemeModel(name: "Insects", emoji:  ["🐝","🐛","🦋","🐌","🪱","🐞","🐜","🪰","🦟","🪳","🪲","🦗","🕷️","🦂"]),
        ThemeModel(name: "Winter", emoji: ["⛄️","🧣","🌨","❄️","🎿","🏂","⛷","🏒","⛸","🛷"])
    ]
    
    //        "Animal" : [🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷],
    //        "Vehicle": ["🚗🚕🚙🛻🚌🚎🏎️🚓🚑🚒🚐🚚🚛🚜"],
    //        "Human"  : ["👨‍🦼🚶🧑‍🦯👩‍🦯🧎🧎‍♀️🏃‍♀️👩‍🦽🧑‍🤝‍🧑👭"],
    
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .black : .blue
            }
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet {
            updateTouches()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.resetGame()
        updateViewFromModel()
        setTheme()
        touches = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        setTheme()
        
    }
    
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.lastIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
    

    private func emojiIdentifier(for card: Card) -> String {
            //Add the emoji choice to the emoji dictionary
            if cardEmoji[card] == nil, emojiChoice.count > 0 {
                let randomStringIndex = getRandomIndex(for: emojiChoice.count)
                cardEmoji[card] = emojiChoice.remove(at: randomStringIndex)
            }
            return cardEmoji[card] ?? "?"
        }
    
    private func setTheme() {
        
        var newThemeIndex = getRandomIndex(for: themes.count)
        
        while newThemeIndex == currentThemeIndex {
            newThemeIndex = getRandomIndex(for: themes.count)
        }
        
        currentThemeIndex = newThemeIndex
        emojiChoice = themes[currentThemeIndex].emoji
    }
    
    private func getRandomIndex(for arrayCount: Int) -> Int {
        return Int(arc4random_uniform(UInt32(arrayCount)))
    }
    
}





