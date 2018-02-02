//
//  ViewController.swift
//  FiveThousand_Revised
//
//  Created by Derek Morefield on 12/12/17.
//  Copyright © 2017 Derek Morefield. All rights reserved.
//
//CONTROLER
import UIKit




class ViewController: UIViewController , DatabaseDelegate   {


    //Code for the various views:
    @IBOutlet weak var ScoreView: UIView!
    @IBOutlet weak var DiceView: UIView!
    
    //DELEGATE DECLARATIONS
    var headerVC : HeaderVC_ViewController?
    var database = DataBaseFiveThousand.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Deposit records in Database
    func enterHighScore (username : String , playerturns enterPlayerTurns : Int , gamescore enterPlayerGamescore : Int ) -> Int? {
        
        //format property values into correct format
        let enterPlayerTurns = Int64(enterPlayerTurns)
        let enterPlayerGamescore = Int64(enterPlayerGamescore)
        
        if let resulting_value = database.addEntry(cname: username, cplayerturns: enterPlayerTurns, cgamescore: enterPlayerGamescore){
            // truncating needed to convert Int64 to Int for 32 bit machine compatability
            print("Resulting value: \(resulting_value)")
            return Int(truncatingIfNeeded : resulting_value)
        }
        else {
            print ("something went wrong")
            return nil
        }
    }
    
    func passDatabase() -> DataBaseFiveThousand {
        let exchangeDatabase = database
        return exchangeDatabase
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        
        if segue.identifier == "ToDiceView" {
            let exchangeData = segue.destination as! DiceViewController
            exchangeData.delegate = headerVC
            print ("Dice View Segue Called")
        }
            
        else if segue.identifier == "ToScoreView"  {
            let destination = segue.destination
            if let destinationHeaderVC = destination as?  HeaderVC_ViewController {
           // headerVCViewController = headerViewController
           // headerViewController.delegate = self
                headerVC = destinationHeaderVC
                print ("Score View Segue Called")
        }

        else {
            print ("could not find segue")
        }
    }
}
    
}




    




