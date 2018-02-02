//
//  Person.swift
//  FiveThousand_Revised
//
//  Created by Derek Morefield on 1/9/18.
//  Copyright © 2018 Derek Morefield. All rights reserved.
//

import Foundation
import UIKit


class Person {
    
    var name : String
    var gameScore : Int
    var turns : Int
    
    init(name : String , gameScore : Int , turns : Int) {
        self.name = name
        self.gameScore = gameScore
        self.turns = turns
    }
    
}
