//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Quasar on 26.01.2023.
//

import UIKit

class ViewController: UIViewController {
 
    
    
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1 ) / 2
    }
    
    private func updateTouches(object: Int) {
        if object > 0 {
            let attributes: [NSAttributedString.Key:Any] = [
                .strokeWidth: 5.0,
                .strokeColor: UIColor.red
            ]
            let attributedString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
            touchLabel.attributedText = attributedString
        }
    }
    private(set) var touches = 0 {
        didSet{
            updateTouches(object: touches)
        
        }
    }
    
    private var cardColor = UIColor(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    private var emojiChoice = [String]()
    private var cardEmoji = [Card:String]()
    private var currentThemeIndex = 0
    
    
    
    private let themes = [
        ThemeModel(name: "Fruits", emoji : ["๐","๐","๐","๐","๐","๐","๐","๐","๐ซ","๐","๐","๐","๐","๐ฅญ","๐","๐ฅฅ","๐ฅ"], colors: [UIColor(red: 1, green: 0.5763723254, blue: 0, alpha: 1), UIColor(red: 0, green: 0, blue: 0, alpha: 1)]),
        ThemeModel(name: "Faces", emoji: ["๐","๐","๐ด","๐ฑ","๐คฃ","๐","๐","๐","๐ฌ","๐คจ"], colors: [UIColor(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), UIColor(red: 0.9999960065, green: 1, blue: 1, alpha: 1) ]),
        ThemeModel(name: "Animal", emoji: ["๐ถ","๐ฑ","๐ผ","๐ฆ","๐ฆ","๐ฏ","๐จ","๐ฎ","๐ท","๐ต"], colors: [UIColor(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), UIColor(red: 0, green: 0, blue: 0, alpha: 1)]),
        ThemeModel(name: "Summer", emoji: ["๐๐ผโโ๏ธ","๐๐ผโโ๏ธ","โ๏ธ","๐","๐ผ","๐","โฑ","๐","๐ฃ","๐ฆ"], colors: [UIColor(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), UIColor(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)]),
        ThemeModel(name: "Insects", emoji:  ["๐","๐","๐ฆ","๐","๐ชฑ","๐","๐","๐ชฐ","๐ฆ","๐ชณ","๐ชฒ","๐ฆ","๐ท๏ธ","๐ฆ"], colors: [UIColor(red: 0.9999960065, green: 0.80, blue: 0, alpha: 1),UIColor(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]),
        ThemeModel(name: "Winter", emoji: ["โ๏ธ","๐งฃ","๐จ","โ๏ธ","๐ฟ","๐","โท","๐","โธ","๐ท"], colors: [UIColor(red: 0, green: 0.4784313725, blue: 1, alpha: 1), UIColor(red: 0.9999960065, green: 1, blue: 1, alpha: 1)])
    ]
    
    //        "Animal" : [๐ญ๐น๐ฐ๐ฆ๐ป๐ผ๐ปโโ๏ธ๐จ๐ฏ๐ฆ๐ฎ๐ท],
    //        "Vehicle": ["๐๐๐๐ป๐๐๐๏ธ๐๐๐๐๐๐๐"],
    //        "Human"  : ["๐จโ๐ฆผ๐ถ๐งโ๐ฆฏ๐ฉโ๐ฆฏ๐ง๐งโโ๏ธ๐โโ๏ธ๐ฉโ๐ฆฝ๐งโ๐คโ๐ง๐ญ"],
    
    func updateViewFromModel() {
        
        scoreNumberLabel.text = "\(game.score)"
        scoreNumberLabel.textColor = cardColor
        scoreTitle.textColor = cardColor
        
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardColor
            }
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet {
            updateTouches(object: touches)
        }
    }
    
    
    @IBOutlet weak var scoreTitle: UILabel!
    
    @IBOutlet weak var scoreNumberLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    
    @IBAction func newGame(_ sender: UIButton) {
        game.resetGame()
        cardEmoji.removeAll()
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
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
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
        cardColor = themes[currentThemeIndex].colors[0]
        themeLabel.text = themes[currentThemeIndex].name
        themeLabel.textColor = cardColor
        view.backgroundColor = themes[currentThemeIndex].colors[1]
        
    }
    
    private func getRandomIndex(for arrayCount: Int) -> Int {
        return Int(arc4random_uniform(UInt32(arrayCount)))
    }
    
}




