//
//  HeaderVC_ViewController.swift
//  FiveThousand_Revised
//
//  Created by Derek Morefield on 1/15/18.
//  Copyright © 2018 Derek Morefield. All rights reserved.
//

import UIKit


class HeaderVC_ViewController: UIViewController , MainVcDelegate , HeaderToNewGameDelegate {

    
    @IBOutlet  var scoreFixedLbl: UILabel!
    @IBOutlet  var gameScoreLbl: UILabel!
    @IBOutlet  var turnLbl: UILabel!
    @IBOutlet  var roundScoreLbl: UILabel!
    @IBOutlet  var handScoreLbl: UILabel!
    @IBOutlet  var BackgroundView: UIView!
    
    
    var turnScoreText = 0  { didSet { turnLbl.text = "\(turnScoreText)"} }
    var gameScoreText = 0  { didSet { gameScoreLbl.text = "\(gameScoreText)"} }
    var handScoreText = 0 { didSet { handScoreLbl.text = "Hand Score: \(handScoreText)"} }
    var roundScoreText = 0 {didSet {roundScoreLbl.text = "\(roundScoreText)"}}
 
    var keepPlaying = true
    
    //Protocol Stubs
    func setGameScore(with gameScore: Int) -> Int{
        gameScoreText += gameScore
        print ("setGameScore Fired. Total gameScore is \(gameScoreText)")
        return gameScoreText

    }
    func setRoundScore(){
        roundScoreText = handScoreText + roundScoreText
        print ("set Round Score Fired. Total round Score is \(roundScoreText)")
    }
    
    func setNumberOfTurns(with turnScore : Int) {
        turnScoreText += turnScore
        print ("setTurnScore Fired. Total turnScore is \(turnScoreText)")
    }
    func setHandScore(with handScore : Int) {
        handScoreText = handScore
    }
    func giveMeRoundScore ()-> Int {
        return Int(roundScoreText)
    }
    func giveMeHandScore () -> Int {
        return Int(handScoreText)
    }
    func zeroTempScores() {
        roundScoreText = 0
        handScoreText = 0
    }
    func giveMeGameScore() -> Int{
        return gameScoreText
    }
    
    func giveMeTurns() -> Int { return turnScoreText}
    
    func endTurn () {
        setRoundScore()
        gameScoreText += roundScoreText
        setNumberOfTurns(with: 1)
        setHandScore(with: 0)
        roundScoreText = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !keepPlaying {
            print ("keep playing is false... appear")
            gameScoreText = 0
            turnScoreText = 0
            roundScoreText = 0
            handScoreText = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackgroundView.setRoundEdgeView()
        
        gameScoreLbl.setRoundEdgeLabel()
        turnLbl.setRoundEdgeLabel()
        roundScoreLbl.setRoundEdgeLabel()
        handScoreLbl.setRoundEdgeLabel()
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDiceView" {
            let toDice = segue.destination as! DiceViewController
            print ("ToDiceViewCalled")
            toDice.delegate = self
        }
        else if segue.identifier == "toHighScrore" {
           
            print ("DB Segue performed from HeaderVC")
        }
            else {
//            code will go here if we need to pass data from headerVC to high score VC.
//            as of now, no data is needed
            }
            
        }
}

