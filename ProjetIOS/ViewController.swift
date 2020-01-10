//
//  ViewController.swift
//  ProjetIOS
//
//  Created by Florian Fizaine on 19/12/2019.
//  Copyright © 2019 Florian Fizaine. All rights reserved.
//

import UIKit
import Blockstack

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var contactTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
        
        let row = indexPath.row
        let actual = contact[row]
        // Configure the cell’s contents.
        cell.contactName.text = actual.name
        cell.contactPhoto.image = UIImage(named: "user.png")
        cell.lastMessage.text = "last message"
            
        return cell
    }
    

    var contact: [Contact]  = [Contact(name: "flo dev", id: "mrfarhenheit.id.blockstack"), Contact(name: "ian", id: "ian.id.blockstack"), Contact(name: "dorine", id: "dorine.id.blockstack")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactTableView.dataSource = self
        self.updateUI()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    private func updateUI(){
    }
}
