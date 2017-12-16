//
//  Concentration.swift
//  Concentration
//
//  Created by Bart Bronselaer on 13/12/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = Array<Card>()
    
    var flipCount = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex : Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
        
    } 
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard (at: \(index)) : chossen index not in the cards")
            if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                
            } else {
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
        assert(numberOfPairsOfCards > 0,"Concentration.init \(numberOfPairsOfCards): you must have at least one pair of cards")
            for _ in 0..<numberOfPairsOfCards {
                let card = Card()
                cards += [card, card]
            }
        // TODO: Shuffle Card
        var shuffledArray = Array<Card>()
        for _ in cards.indices {
            let randomNumber = cards.count.arc4random
            shuffledArray.append(cards[randomNumber])
            cards.remove(at: randomNumber)
        }
        cards = shuffledArray
    }

}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else {
            if self < 0 {
                return -Int(arc4random_uniform(UInt32(abs(self))))
                
            } else  {
                return 0
            }
        }        
    }
}
