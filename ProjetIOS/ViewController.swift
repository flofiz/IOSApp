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

    var contact: [Contact]  = [Contact(name: "flo dev", id: "mrfarhenheit.id.blockstack"), Contact(name: "ian", id: "ian.id.blockstack"), Contact(name: "dorine", id: "dorine.id.blockstack")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
    
    private func updateUI(){
    }
}
