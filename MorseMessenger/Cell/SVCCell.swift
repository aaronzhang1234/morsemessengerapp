//
//  SVCCell.swift
//  MorseMessenger
//
//  Created by Aaron Zhang on 1/30/21.
//

import UIKit
protocol SVCCellDelegate {
    func buttonPressed(message:String, cellIndex:Int)
}
class SVCCell:UITableViewCell{
    @IBOutlet weak var button: UIButton!
    
    var delegate:SVCCellDelegate?
    
    var identifier = "id"{
        didSet{
            button.setTitle(identifier, for: .normal)
        }
    }
    var message:String?
    var cellIndex = 0
    var isPlaying=false{
        didSet{
            if(isPlaying){
                button.setImage(UIImage(systemName: "volume.3.fill"), for: .normal)
            }else{
                button.setImage(nil, for:.normal)
            }
        }
    }
    
    override func prepareForReuse() {
        identifier=""
    }
    @IBAction func buttonOnClick(_ sender: Any) {
        guard let message = message else { return }
        delegate?.buttonPressed(message:message, cellIndex: cellIndex)
    }
    
}

