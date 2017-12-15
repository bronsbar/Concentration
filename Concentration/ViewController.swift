//
//  ViewController.swift
//  Concentration
//
//  Created by Bart Bronselaer on 12/12/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {
        get {
            return (cardButtons.count + 1 ) / 2
        }
    }
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
   
    
    @IBAction func touchCard(_ sender: UIButton) {
       
        if let cardNumber = cardButtons.index(of: sender){
          game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        emojiChoices = ["🎃","👻","🦊","🐌","🙉","🐯","👿","🙀","🐍","🐔","🌸","🦋","😎","🐸","🌽","🍏","🍌","⛸","🎾","⚽️","🎯"]
        emoji = [:]
        game.resetGame()
        updateViewFromModel()
    
    }
    
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for : card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips : \(game.flipCount)"
    }
    
    var emojiChoices = ["🎃","👻","🦊","🐌","🙉","🐯","👿","🙀","🐍","🐔","🌸","🦋","😎","🐸","🌽","🍏","🍌","⛸","🎾","⚽️","🎯"]
    var emoji = Dictionary<Int, String>()
    
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
       return emoji[card.identifier] ?? "?"
    }
}

