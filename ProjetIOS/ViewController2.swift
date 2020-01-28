//
//  ViewController2.swift
//  ProjetIOS
//
//  Created by Florian Fizaine on 10/01/2020.
//  Copyright © 2020 Florian Fizaine. All rights reserved.
//

import UIKit
import Blockstack

class ViewController2: UIViewController, UITableViewDataSource {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messagesTableView: UITableView!
    var contact: Contact?
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = contact?.name
        messagesTableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (contact?.conversation.myMessages.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sended", for: indexPath) as! SendCell
        
        let row = indexPath.row
        let actual = contact?.conversation.myMessages[row]
        // Configure the cell’s contents.
        cell.sendMessageLabel.text = actual?.message
            
        return cell
    }
    
    @IBAction func onSendPressed(_ sender: Any) {
        if(messageTextField.text != "" && messageTextField.text != nil)
        {
            contact?.conversation.sendMessage(message: Conversation.Message(name: self.name! ,message: messageTextField.text! , date: Date()))
            self.messagesTableView.reloadData()
        }
    }
    
}
