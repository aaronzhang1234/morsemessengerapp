//
//  SVCCell.swift
//  MorseMessenger
//
//  Created by Aaron Zhang on 1/30/21.
//

import UIKit
protocol SVCCellDelegate {
    func buttonPressed()
}
class SVCCell:UITableViewCell{
    @IBOutlet weak var button: UIButton!
    var delegate:SVCCellDelegate?
    
    var cellText = "what"{
        didSet{
            button.setTitle(cellText, for: .normal)
        }
    }
    override func prepareForReuse() {
        cellText=""
    }
    @IBAction func buttonOnClick(_ sender: Any) {
        delegate?.buttonPressed()
        print("hello")
    }
    
}

