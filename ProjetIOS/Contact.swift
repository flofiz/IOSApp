//
//  Contact.swift
//  ProjetIOS
//
//  Created by Florian Fizaine on 10/01/2020.
//  Copyright © 2020 Florian Fizaine. All rights reserved.
//

import Foundation
class Contact{
    var name:String
    var id:String
    var conversation:Conversation
    
    init(name:String, id:String) {
        self.name = name
        self.id = id
        conversation = Conversation(name: name, id: id)
    }
}
