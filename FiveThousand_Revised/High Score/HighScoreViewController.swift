//
//  HighScoreViewController.swift
//  FiveThousand_Revised
//
//  Created by Derek Morefield on 1/9/18.
//  Copyright © 2018 Derek Morefield. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController {

    var person : [Person] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var highScoreTitleLbl: UILabel!
    
    var db  = DataBaseFiveThousand.shared()
    var player_list = [Player]()
    
    @IBAction func clearHighScoresBtn(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Are you sure?", message:
            "Tap Clear to clear high scores", preferredStyle: UIAlertControllerStyle.alert)
        // reset all dice to their normal state (UI + Model)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil ))
        alertController.addAction(UIAlertAction(title: "Clear", style: UIAlertActionStyle.default,handler: clearHighScore  ))
        
        self.present(alertController, animated: true, completion: nil)
        // bring roundscore to 0 (UI)
        
    }
    
    func clearHighScore (_ : UIAlertAction) {
        db.destroy()
        
        let database = db
        player_list = database.getHighScores()
        
        //to refresh on the main thread
        tableView.reloadData()

    }
    
    
    
    
    @IBAction func dismissLeaderBoards(_ sender: Any) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor.white
        highScoreTitleLbl.addBottomBorderWithColor(color: color , width: 3.0)
        
        
        let database = db
        player_list = database.getHighScores()
        
        
        
        print ("There are \(player_list.count) players in the leaderboard")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.allowsSelection = false
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HighScoreViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let myPerson  = player_list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreEntryCell") as! HS_Cell_VCTableViewCell
        
        //Assign the properties of the Player object
        //to the cell 
        cell.setCell(person: myPerson)
        print ("fire")
        return cell
    }
    
    
    
    
}
