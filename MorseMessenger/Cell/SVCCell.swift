//
//  SVCCell.swift
//  MorseMessenger
//
//  Created by Aaron Zhang on 1/30/21.
//

import UIKit

class SVCCell:UITableViewCell{
    @IBOutlet weak var button: UIButton!
    var cellText = "what"{
        didSet{
            button.setTitle(cellText, for: .normal)
        }
    }
    override func prepareForReuse() {
        cellText=""
    }
    @IBAction func buttonOnClick(_ sender: Any) {
        print("hello")
    }
    
}

