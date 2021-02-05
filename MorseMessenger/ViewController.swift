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

    
    var input:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))

       //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
       //tap.cancelsTouchesInView = false

       view.addGestureRecognizer(tap)
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

   //Calls this function when the tap is recognized.
   @objc func dismissKeyboard() {
       view.endEditing(true)
   }
    @IBAction func buttonOnClick(_ sender: Any) {
        input = textfield.text
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SecondViewController else{return}
        destination.input = input
    }
}

