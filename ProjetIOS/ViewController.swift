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
    var contact: [Contact] = [];
    var contactList: [ContactInfo] = [];
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    let filename = "NewContact.json"
    var name = ""
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactTableView.dataSource = self
        self.initContact()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let convController = segue.destination as? ViewController2,
            let index = contactTableView.indexPathForSelectedRow?.row
            else {
                return
        }
        convController.contact = contact[index]
        convController.name = name
    }
    
    @IBAction func onAddContactPressed(_ sender: Any) {
        let addContact = UIAlertController(title: "Add Contact", message: "Add information about contact", preferredStyle: .alert)
        addContact.addTextField(configurationHandler: {
            (textField) in textField.placeholder = "name"
        })
        addContact.addTextField(configurationHandler: {
            (textField) in textField.placeholder = "Blockstack ID"
        })
        
        addContact.addAction(UIAlertAction(title: "Valider", style: .default, handler: {
            (_) in
            let nameTextField = addContact.textFields![0] as UITextField
            let idTextField = addContact.textFields![1] as UITextField
            if nameTextField.text != "" && idTextField.text != "" && nameTextField.text != nil && idTextField.text != nil
            {
                self.contactList.append(ContactInfo(name: nameTextField.text!, id: idTextField.text!))
                self.contact.append(Contact(name: nameTextField.text!, id: idTextField.text!))
                let encoder = JSONEncoder()
                let newContactList = try! String(data: encoder.encode(self.contactList), encoding: .utf8)
                print(newContactList!)
                Blockstack.shared.putFile(to: self.filename, text: newContactList!, sign: true, signingKey: nil){
                    (publicURL, error) in
                    if(error != nil){
                        print("put contact error")
                    }else{
                        print("put file success \(publicURL ?? "NA")")
                    }
                }
                self.contactTableView.reloadData()
            }
        }))
        self.present(addContact, animated: true, completion: nil)
    }
    
    @IBAction func unwindToMainVC(_ unwindSegue: UIStoryboardSegue)
    {
        
        // Use data from the view controller which initiated the unwind segue
        
        if unwindSegue.identifier == "conv2list" {
            let sourceViewController = unwindSegue.source as! ViewController2
            sourceViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    private func updateUI(){
        
    }
    
    private func initContact()
    {
        self.contact = []
        self.contactList = []
        if Blockstack.shared.isUserSignedIn()
        {
            Blockstack.shared.getFile(at: self.filename, verify: true){
                response, error in
                if error != nil{
                    self.contact = []
                }else{
                    if response != nil{
                        let decoder = JSONDecoder()
                        let text = (response as? DecryptedValue)?.plainText
                        print(text!)
                        let data = text?.data(using: .utf8)
                        self.contactList = try! decoder.decode([ContactInfo].self, from: data!)
                        for person in self.contactList{
                            self.contact.append(Contact(name: person.name, id: person.id))
                            print("pass")
                        }
                         self.contactTableView.reloadData()
                    }
                }
            }
           
        }
    }
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        if Blockstack.shared.isUserSignedIn()
        {
            print("Sign Out")
            Blockstack.shared.signUserOut()
            self.name = ""
            self.contact = []
            self.contactList = []
            self.contactTableView.reloadData()
        }else{
            print("Sign In")
            Blockstack.shared.signIn(redirectURI: URL(string: "https://heuristic-brown-7a88f8.netlify.com/redirect.html")!, appDomain: URL(string: "https://heuristic-brown-7a88f8.netlify.com")!, scopes: [.storeWrite, .publishData]){
                authResult in
                switch authResult {
                case .success(let userData):
                    print("sign in success", userData.profile?.name as Any)
                    self.name = (userData.profile?.name)!
                    self.initContact()
                case .cancelled:
                    print("Sign in cancelled")
                case .failed(let error):
                    print("sign in failed", error ?? "n/a")
                }
            }
            
        }
    }
    
    
}
