//
//  Conversation.swift
//  ProjetIOS
//
//  Created by Florian Fizaine on 10/01/2020.
//  Copyright © 2020 Florian Fizaine. All rights reserved.
//

import Foundation
import Blockstack
class Conversation{
    var messages:[Message]
    var name:String
    var id: String
    
    struct Message {
        var name:String
        var message:String
        var date: Date
    }
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
        self.messages = []
        Blockstack.shared.getFile(at: "\(self.name).json", username:"\(self.name).id.blockstack"){
            response, error in
            if error != nil {
                self.messages = []
            }
            else {
                self.messages = [Message(name: "ian", message: "message", date: Date())]
            }
        }
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    
}
