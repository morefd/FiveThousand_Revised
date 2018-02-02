//
//  player_model.swift
//  FiveThousand_Revised
//
//  Created by Derek Morefield on 1/3/18.
//  Copyright © 2018 Derek Morefield. All rights reserved.
//

import Foundation



class Player {
    let id: Int64?
    var name: String

    var playerTurns : Int64?
    var gameScore : Int64?
  //  var highScore: Int64?
    //var handScore : Int64?
    

    init(id: Int64 , numberOfPlayers: Int) {
        self.id = id
        name = ""
        playerTurns = 0
        gameScore = 0
    
    }

    
    //removed handScore and highScore from init
    init(id: Int64, name: String, playerTurns : Int64 , gameScore: Int64 ) {
        self.id = id
        self.name = name
        self.playerTurns = playerTurns
        self.gameScore = gameScore
     //   self.highScore = highScore
     //   self.handScore = handScore
        print ("record \(id) returned with a name of \(name), a gameScore of \(gameScore), and turns of \(playerTurns)")
    }
    
}

