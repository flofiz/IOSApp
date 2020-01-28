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
        let row = indexPath.row
        let actual = contact?.conversation.allMessages[row]
       
        if(actual?.name == self.name)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sended", for: indexPath) as! SendCell
            cell.sendMessageLabel.text = actual?.message
            return cell
        }
        else
        {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "received", for: indexPath) as! ReceiveCell
            cell.receiveMessageLabel.text = actual?.message
            return cell

        }
        // Configure the cell’s contents.
        
            
        
    }
    
    @IBAction func onSendPressed(_ sender: Any) {
        if(messageTextField.text != "" && messageTextField.text != nil)
        {
            contact?.conversation.sendMessage(message: Conversation.Message(name: self.name! ,message: messageTextField.text! , date: Date()))
            contact?.conversation.update()
            self.messagesTableView.reloadData()
        }
        messageTextField.text = ""
    }
    
}
