//
//  NewGamePopup.swift
//  FiveThousand_Revised
//
//  Created by Derek Morefield on 1/29/18.
//  Copyright © 2018 Derek Morefield. All rights reserved.
//

import UIKit



//Potentially will be needed to start new games different way
protocol HeaderToNewGameDelegate : class {
    var keepPlaying : Bool {get set}
    
}

protocol ModelKeepPlayingDelegate : class {
    func keepPlaying (with : Bool)
}


class NewGamePopup: UIViewController  {
    
    
    @IBOutlet weak var newGameFixedLbl: UILabel!
    @IBOutlet weak var newGameView: NSLayoutConstraint!
    
    var delegateNG : HeaderToNewGameDelegate?

    
    @IBAction func newGameBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
        self.present(vc, animated: true, completion: nil)

    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
