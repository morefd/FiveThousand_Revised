//
//  HS_Cell_VCTableViewCell.swift
//  FiveThousand_Revised
//
//  Created by Derek Morefield on 1/9/18.
//  Copyright © 2018 Derek Morefield. All rights reserved.
//

import UIKit

class HS_Cell_VCTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var turnsLbl: UILabel!
    
    
    func setCell (person : Player) {
        
        let name = String(describing: person.name)
        let gameScore  = String(describing : person.gameScore!)
        let playerTurns  = String(describing: person.playerTurns!)
        
        nameLbl.text = name
        scoreLbl.text = gameScore
        turnsLbl.text = playerTurns
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
