//
//  ViewController.swift
//  MorseMessenger
//
//  Created by Aaron Zhang on 1/30/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textfield: UITextField!
    
    var counter = 0
    var input:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))

       //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
       //tap.cancelsTouchesInView = false

       view.addGestureRecognizer(tap)
   }

   //Calls this function when the tap is recognized.
   @objc func dismissKeyboard() {
       view.endEditing(true)
   }
    @IBAction func buttonOnClick(_ sender: Any) {
        input = textfield.text
        counter = counter + 1
        button.setTitle("Counter is: \(counter)", for: .normal)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SecondViewController else{return}
        destination.input = input
    }
}

