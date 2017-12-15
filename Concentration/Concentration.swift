//
//  Concentration.swift
//  Concentration
//
//  Created by Bart Bronselaer on 13/12/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import Foundation

class Concentration {
    var cards = Array<Card>()
    
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        flipCount += 1
        }
    }
    
    func resetGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        flipCount = 0
    }
        
    init (numberOfPairsOfCards: Int) {
            for _ in 0..<numberOfPairsOfCards {
                let card = Card()
                cards += [card, card]
            }
        // TODO: Shuffle Card
        var shuffledArray = Array<Card>()
        for _ in cards.indices {
            let randomNumber = cards.count.randomIndex
            shuffledArray.append(cards[randomNumber])
            cards.remove(at: randomNumber)
        }
        cards = shuffledArray
    }

}
extension Int {
    var randomIndex: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else {
            if self < 0 {
                return Int(arc4random_uniform(UInt32(abs(self))))
                
            } else  {
                return 0
            }
        }        
    }
}
