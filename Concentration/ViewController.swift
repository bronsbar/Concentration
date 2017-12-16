//
//  ViewController.swift
//  Concentration
//
//  Created by Bart Bronselaer on 12/12/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {
        get {
            return (cardButtons.count + 1 ) / 2
        }
    }
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
   
    
    @IBAction private func touchCard(_ sender: UIButton) {
       
        if let cardNumber = cardButtons.index(of: sender){
          game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    @IBAction private func newGameButton(_ sender: UIButton) {
        emojiChoices = ["🎃","👻","🦊","🐌","🙉","🐯","👿","🙀","🐍","🐔","🌸","🦋","😎","🐸","🌽","🍏","🍌","⛸","🎾","⚽️","🎯"]
        emoji = [:]
        game.resetGame()
        updateViewFromModel()
    
    }
    
    
     private func updateViewFromModel() {
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
    
    private var emojiChoices = ["🎃","👻","🦊","🐌","🙉","🐯","👿","🙀","🐍","🐔","🌸","🦋","😎","🐸","🌽","🍏","🍌","⛸","🎾","⚽️","🎯"]
    
    private var emoji = Dictionary<Int, String>()
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
       return emoji[card.identifier] ?? "?"
    }
}

