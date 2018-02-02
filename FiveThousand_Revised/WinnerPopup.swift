//
//  WinnerPopup.swift
//  FiveThousand_Revised
//
//  Created by Derek Morefield on 1/24/18.
//  Copyright © 2018 Derek Morefield. All rights reserved.
//

import UIKit
import EFCountingLabel




class WinnerPopup: UIViewController , UITextFieldDelegate  {

    
   weak var databaseDelegate : DatabaseDelegate?
    weak var delegate : MainVcDelegate?

    
    var name : String = ""
    var gameScore : Int = 0
    var gameTurns : Int = 0
    

    
    @IBOutlet weak var inputErrorLbl: UILabel!
    
    
    //need to create a delegate to write to the DB
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLbl: EFCountingLabel!
    @IBOutlet weak var wantToSaveScoreLbl: UILabel!

    
    //transform this one to a EF Counting Label
    @IBOutlet weak var scoreLbl: EFCountingLabel!
    @IBOutlet weak var turnsLbl: EFCountingLabel!

    
   // var score = 0 //{ didSet { scoreLbl.text = "\(score)"} }
  //  var turns = 0 //{ didSet { turnsLbl.text = "\(turns)"} }
    
    func setGameScore (with enterGameScore : Int) {
        gameScore = enterGameScore
    
    }
    
    

    @IBOutlet weak var enterNameText: UITextField!
    
    @IBAction func submitScoreBtn(_ sender: Any) {
        
        
        
        }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    func presentNewGamePopup (){
        let vc = NewGamePopup()
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
    
        scoreLbl.method = EFLabelCountingMethod.easeInOut
        scoreLbl.format = "%d"
        let formatGameScore = CGFloat (gameScore)
        scoreLbl.countFrom(0.0 , to: formatGameScore , withDuration: 1.5)
 
        turnsLbl.method = EFLabelCountingMethod.easeInOut
        turnsLbl.format = "%d"
        let formatTurns = CGFloat (gameTurns)
        turnsLbl.countFrom(0.0 , to: formatTurns , withDuration: 1.5)
        
    }
    
    func saveData (name : String  , gameScore: Int , turns : Int) {
        
        let VC = ViewController()
        self.databaseDelegate = VC
        
        if enterNameText.text != "" , enterNameText.text != "Enter Your Name" {
            let _ = databaseDelegate?.enterHighScore(username: name, playerturns: turns, gamescore: gameScore)
        }
        else{
        }
    }
    
    func textField(_ textField: UITextField, maxChar : Int) -> Bool {
        
        let currentString: String = textField.text! as String
        print ("Current String is \(currentString.count) characters")
        return (currentString.count <= maxChar)
    }
    
    func setErrorMessage (textField : UITextField , maxLength: Int) {
        
        textField.text = "Limit \(maxLength) characters. "
        textField.textColor = UIColor.red
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
            
        if segue.identifier == "toNewGamePopup" {
            
            if textField (enterNameText, maxChar: 15){
                name = enterNameText.text!
                
                saveData(name: enterNameText.text!, gameScore: gameScore, turns: gameTurns)
                
            }
            print ("toNewGamePopup called")
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
