//
//  SVCCell.swift
//  MorseMessenger
//
//  Created by Aaron Zhang on 1/30/21.
//

import UIKit
protocol SVCCellDelegate {
    func buttonPressed(message:String)
}
class SVCCell:UITableViewCell{
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var identifierLabel: UILabel!
    
    var delegate:SVCCellDelegate?
    
    var identifier = "id"{
        didSet{
            identifierLabel.text = identifier
        }
    }
    var message:String?
    
    override func prepareForReuse() {
        identifier=""
    }
    @IBAction func buttonOnClick(_ sender: Any) {
        guard let message = message else { return }
        delegate?.buttonPressed(message:message)
        print("hello")
    }
    
}

