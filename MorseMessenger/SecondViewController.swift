//
//  SecondViewController.swift
//  MorseMessenger
//
//  Created by Aaron Zhang on 1/30/21.
//

import UIKit
import PusherSwift
var pusher:Pusher!
import AudioToolbox
import CoreHaptics

class SecondViewController:UIViewController{
    
    var pusher:Pusher!
    let alphaNumToMorse = [
        "A": ".-",
        "B": "-...",
        "C": "-.-.",
        "D": "-..",
        "E": ".",
        "F": "..-.",
        "G": "--.",
        "H": "....",
        "I": "..",
        "J": ".---",
        "K": "-.-",
        "L": ".-..",
        "M": "--",
        "N": "-.",
        "O": "---",
        "P": ".--.",
        "Q": "--.-",
        "R": ".-.",
        "S": "...",
        "T": "-",
        "U": "..-",
        "V": "...-",
        "W": ".--",
        "X": "-..-",
        "Y": "-.--",
        "Z": "--..",
        "1": ".----",
        "2": "..---",
        "3": "...--",
        "4": "....-",
        "5": ".....",
        "6": "-....",
        "7": "--...",
        "8": "---..",
        "9": "----.",
        "0": "-----",
        " ": " ",
    ]
    
    @IBOutlet weak var waiting: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var engine: CHHapticEngine?
    var player: CHHapticPatternPlayer?

    
    var tableViewRows:[MorseCell] = []{
        didSet{
            waiting.isHidden = true
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
        let options = PusherClientOptions(
            host:.cluster("us2")
        )
        pusher = Pusher(
            key: "d03b2f9746fcb31a831d",
            options: options
        )
        let channel = pusher.subscribe(input?.description ??  "")
        
        let _ = channel.bind(eventName: "morsemessenger", eventCallback: { (event: PusherEvent) in
            if let data = event.data {
                self.parsePusherEvent(data)
            }
        })
        pusher.connect()

        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "SVCCell", bundle: .main), forCellReuseIdentifier: "Cell")
        tableview.separatorStyle = .none
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pusher.disconnect()
    }
    func parsePusherEvent(_ eventData: String){
        let jsonData = eventData.data(using: .utf8)!
        let pusherResponse = try! JSONDecoder().decode(PusherResponse.self, from: jsonData)
        let pusher_message = pusherResponse.message
        let message_array = pusher_message.components(separatedBy: "|")
        tableViewRows.append(MorseCell(identifer: message_array[0], message: message_array[1]))
    }
    
    func vibrateMessage(_ message: String){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        try? player?.cancel()
        var morse_array:[CHHapticEvent]=[]
        var overallTime = 0.0
        for index in 0...message.count-1{
            let message_letter = String(message[index])
            let morse_code = alphaNumToMorse[message_letter] ?? ""
            for morse_index in 0...morse_code.count-1{
                let morse_character = morse_code[morse_index]
                switch(morse_character){
                case ".":
                    morse_array.append(CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: overallTime, duration:0.5))
                    overallTime += 0.6
                    break
                case "-":
                    morse_array.append(CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: overallTime, duration:1.0))
                    overallTime += 1.1
                    break
                case " ":
                    morse_array.append(CHHapticEvent(eventType: .audioContinuous, parameters: [], relativeTime: overallTime, duration:1.0))
                    overallTime += 1.1
                    break
                default:
                    break
                }
            }
            overallTime += 0.5
        }
        do {
            let pattern = try CHHapticPattern(events: morse_array, parameters: [])
            player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}
extension SecondViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SVCCell else{return UITableViewCell()}
        let currentCell = tableViewRows[indexPath.row]
        cell.delegate = self
        cell.message = currentCell.message
        cell.identifier = currentCell.identifer
        return cell
    }
}
extension SecondViewController:SVCCellDelegate{
    func buttonPressed(message:String) {
        vibrateMessage(message)
    }
}

struct MorseCell{
    var identifer:String
    var message:String
}
