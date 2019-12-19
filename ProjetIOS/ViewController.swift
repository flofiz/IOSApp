//
//  ViewController.swift
//  ProjetIOS
//
//  Created by Florian Fizaine on 19/12/2019.
//  Copyright © 2019 Florian Fizaine. All rights reserved.
//

import UIKit
import Blockstack

class ViewController: UIViewController {

    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var ConnectedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.ConnectedLabel.isHidden = true
    }
    
    private func updateUI(){
        DispatchQueue.main.async {
            if Blockstack.shared.isUserSignedIn(){
                let retrievedUserData = Blockstack.shared.loadUserData()
                print(retrievedUserData?.profile?.name as Any)
                let name = retrievedUserData?.profile?.name ?? "sans nom"
                self.ConnectedLabel?.text = "Bonjours, \(name)"
                self.ConnectedLabel?.isHidden = false
                self.SignInButton?.setTitle("Sign Out", for: .normal)
                print("updated")
            }
            else {
                self.ConnectedLabel?.text = "Non connecté"
                self.SignInButton?.setTitle("Sign In", for: .normal)
                print("signed out")
            }
        }
    }


}

