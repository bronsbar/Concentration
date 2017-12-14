//
//  Card.swift
//  Concentration
//
//  Created by Bart Bronselaer on 13/12/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier :Int
    
    static var identifierFactory : Int = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    
    }
    
    init (){
        self.identifier = Card.getUniqueIdentifier()
    }
}
