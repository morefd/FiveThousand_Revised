//
//  FiveThousand_revised.swift
//
//FiveThousand_Revised
//
//  Created by Derek Morefield on 12/12/17.
//  Copyright © 2017 Derek Morefield. All rights reserved.
//
//MODEL
import Foundation


class FiveThousand  {
        
    var game_dice = [Dice]()
    
    var keepPlaying  : Bool = false
    
    func keepPlaying (with : Bool) -> Bool {
        return keepPlaying
    }
    

    func update_DiceVal (for myDice: Int , with myDiceVal: Int){
            game_dice[myDice].diceVal = myDiceVal
            //simulateSpecificDiceRoll()
        
        //commenting this temporarily for testing
            let myVal = game_dice[myDice].diceVal
        
            print("This value has been passed to the model \(myVal)" )
    }

    func select_dice (for dice_selected: Int) -> Bool{
        if !game_dice[dice_selected].isUsed  , (game_dice[dice_selected].isSelected) {
            game_dice[dice_selected].isSelected = false
            print ("The selected dice has now turned \(game_dice[dice_selected].isSelected)")
        }
        else if !game_dice[dice_selected].isUsed , !(game_dice[dice_selected].isSelected) {
            game_dice[dice_selected].isSelected = true
            print ("The selected dice has now turned \(game_dice[dice_selected].isSelected)")
        }
        else if (game_dice[dice_selected].isUsed){
            game_dice[dice_selected].isSelected = false
            print ("this dice has already been used")
        }
        return game_dice[dice_selected].isSelected
    }
    
    func evaluate_Selected () -> Int {
        
        var roundScore = 0 //keep track of the round score
        
        var (_  , numberDict ) = isThreeofaKind(selectedFlag: true)
        let isStraight = checkForStraight(diceDict:  numberDict)
        
        
        if isStraight {
            roundScore += 1500
        }
        //to find 3 of a kind
        else if (numberDict["numberOnes"]!) >= 3 {
            roundScore += 1000
            numberDict["numberOnes"] = numberDict["numberOnes"]! - 3
        }
        else if (numberDict["numberTwos"]!) >= 3 {
            roundScore += 200
            numberDict["numberTwos"] = numberDict["numberTwos"]! - 3
            }
        else if (numberDict["numberThrees"]!) >= 3 {
            roundScore += 300
            numberDict["numberThrees"] = numberDict["numberThrees"]! - 3
            }
        else if (numberDict["numberFours"]!) >= 3 {
            roundScore += 400
            numberDict["numberFours"] = numberDict["numberFours"]! - 3
            }
        else if (numberDict["numberFives"]!) >= 3 {
            roundScore += 500
            numberDict["numberFives"] = numberDict["numberFives"]! - 3
            }
        else if (numberDict["numberSixes"]!) >= 3 {
            roundScore += 600
            numberDict["numberSixes"] = numberDict["numberSixes"]! - 3
            }
        
        //another statement for residuals
        if (!isStraight) , (numberDict["numberOnes"]!) <= 2 || (numberDict["numberFives"]!) <= 2 {
            roundScore += (100 * (numberDict["numberOnes"]!)) + (50 * (numberDict["numberFives"]!))
    }

            print (numberDict)
            
            numberDict["numberOnes"] =  0
            numberDict["numberFives"] = 0
        
        //   print (numberDict)
        return (roundScore)
    }

    //    TODO: create a function to support a user rolling 2 triples (222,444)
    
    func useDice (for dice_selected: Int){
        // take the dice which are selected and make them
        // invalid until the person busts or they end their turn
        game_dice[dice_selected].isUsed = true
      
    }
    
    func print_state_all_dice () {
        for dice in game_dice {
            print(dice.isSelected)
        }
    }
    
    func checkForStraight (diceDict :  [String : Int] )  -> Bool{
        // either loop through the dict, pull out all values by flag
        // could optimize this by sorting the dict out by value lowest to greatest and skipping everything if the first number is a one.  This however is not scalable if you were to add more dice.
        
        if diceDict["numberOnes"]! ==  1 , diceDict["numberTwos"]! ==  1 , diceDict["numberThrees"]! ==  1 , diceDict["numberFours"]! ==  1, diceDict["numberFives"]! ==  1 , diceDict["numberSixes"]! ==  1 {
                return true
            }
            else {
                return false
            }
        }
    func isOneSelected () -> Bool {
        
        var count = 0
        
        
        for dice in game_dice {
            if !dice.isUsed , dice.isSelected {
                count += 1
            }
        }
        print ("There are \(count) dice selected but not used")
        if count > 0 {
            return true
        }
        else {return false}
    }
    
    
    
    func isThreeofaKind (selectedFlag : Bool) -> (isThreeofaKind : Bool , resultDict : [String: Int]) {
       
        var diceValuesArray = [Int]()
        var isThreeofaKind = false
        var numberDict : [String : Int] = ["numberOnes": 0 ,
                                           "numberTwos" : 0,
                                           "numberThrees" : 0,
                                           "numberFours" : 0,
                                           "numberFives" : 0,
                                           "numberSixes" : 0]
        if (selectedFlag) {
            for dice in game_dice {
                if !dice.isUsed ,  dice.isSelected {
                    diceValuesArray.append(dice.diceVal)
                }
            }
        }
        else  {
                for dice in game_dice {
                    if !dice.isUsed  {
                        diceValuesArray.append(dice.diceVal)
                    }
                }
            }
        
        //to build the dictionary
        for element in diceValuesArray {
            if element == 1 {
                numberDict["numberOnes"]! +=  1
            }
            else if element == 2 {
                numberDict["numberTwos"]! += 1
            }
            else if element == 3 {
                numberDict["numberThrees"]! += 1
            }
            else if element == 4 {
                numberDict["numberFours"]! +=  1
            }
            else if element == 5 {
                numberDict["numberFives"]! +=  1
            }
            else if element == 6 {
                numberDict["numberSixes"]! += 1
            }
        }
    
        var i = 0
        
        for key in numberDict {
            if key.value >= 3  {
                i += 1
        }
            if i >= 1 {
                isThreeofaKind = true
            }
    }
        return (isThreeofaKind , numberDict)
}
    
    
    func is_Bust () -> Bool {
        var isGameOver = false
        var counter = 0
        
        let (isThreeFlag , _) = isThreeofaKind(selectedFlag:  false)
        
        if isThreeFlag {
            isGameOver = false
        }
        else {
            for dice in game_dice {
                if (dice.isUsed){
                    counter += 1
                }
                else if (!(dice.isUsed) && dice.diceVal != 5 && dice.diceVal != 1) {
                    counter += 1
                }
                else /* if */ {
                    //Handle 3 of a kind here
                }
        }
            if counter ==  game_dice.count {
                isGameOver = true
            }
    }
        return isGameOver
}
    
    func give_Single_Die_Value (for dice_selected : Int) -> Int {
        return game_dice[dice_selected].diceVal
    }
 
    func changeResetDie(for dice_selected: Int) {
        game_dice[dice_selected].isUsed = false
        game_dice[dice_selected].isSelected = false
    }
    func changeToResetDefaultDieVal(for dice_selected: Int) {
        game_dice[dice_selected].diceVal = 0
    }
    
    
    //Functions for Finding Die States
     func isDieSelected (for dice_selected : Int ) -> Bool {
        
        if game_dice[dice_selected].isSelected {
            return true
        }
        else {
        return false
    }
}
    func isDieUsed (for dice_selected : Int ) -> Bool {
        if game_dice[dice_selected].isUsed {
            return true
        }
        else {
            return false
      }
}
    
    
    //INITIALIZER METHOD
    init(numberOfDice: Int) {
        for _ in 1...numberOfDice{
            let die = Dice(diceVal: 0)
            game_dice.append(die)
            
            print ("Die \(game_dice.count) has been created and is ready for action!")
        }
    }
 
    //DEBUGGER METHODS
    func print_all_my_dice_values () {
        for alpha in game_dice {
            print ("DiceValue = \(alpha.diceVal)" )
        }
    }
    func print_all_my_dice_states () {
        for dice in game_dice {
            print(dice.isUsed)
        }
    }
    func simulateSpecificDiceRoll () {
        game_dice[0].diceVal = 4
        game_dice[1].diceVal = 4
        game_dice[2].diceVal = 4
        game_dice[3].diceVal = 6
        game_dice[4].diceVal = 3
        game_dice[5].diceVal = 2
    }
    
    // TODO: Utility Method to simulate a straight for debugging.
    func giveMeAStraight (for numberOfDice: Int)  {
     //   var diceValStraight = 1
        game_dice[numberOfDice].diceVal = 0 // change this later
    }
}

struct Dice {
    var isSelected = false
    var diceVal: Int
    var isUsed = false
    //var diceIndex: Int
    
    init (diceVal: Int){
        self.diceVal = 0
    }
    
}





