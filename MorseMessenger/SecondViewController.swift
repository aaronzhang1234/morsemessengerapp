//
//  SecondViewController.swift
//  MorseMessenger
//
//  Created by Aaron Zhang on 1/30/21.
//

import UIKit
class SecondViewController:UIViewController{
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var tableViewRows:[String] = []{
        didSet{
            tableview.reloadData()
        }
    }
    
    var input:String?{
        didSet{
            print("\(input)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "SVCCell", bundle: .main), forCellReuseIdentifier: "Cell")
        tableview.separatorStyle = .none
    }
    
    @IBAction func buttonOnClick(_ sender: Any) {
        guard let text = textfield.text else{return}
        tableViewRows.append(text)
    }
}
extension SecondViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SVCCell else{return UITableViewCell()}
        cell.cellText = tableViewRows[indexPath.row]
        return cell
    }
    
    
}
