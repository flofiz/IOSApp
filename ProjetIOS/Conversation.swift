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
    var myMessages:[Message]
    var allMessages:[Message]
    var name:String
    var id: String
    

    
    struct Message: Codable {
        var name:String
        var message:String
        var date: Date
    }
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
        self.messages = []
        self.myMessages = []
        self.allMessages = []
        Blockstack.shared.getFile(at: "\(self.name).json", username:"\(self.name).id.blockstack"){
            response, error in
            if error != nil {
               print("conv error")
               self.messages = []
            }
            else {
                
                if(response != nil)
               {
                   let decoder = JSONDecoder()
                   self.messages = try! [decoder.decode(Message.self, from: response as! Data)]
               }
            }
        }
        Blockstack.shared.getFile(at: "\(self.name).id.blockstack.json", verify: true){
            response, error in
            if error != nil {
                self.messages = []
            }
            else {
                if(response != nil)
                {
                    let decoder = JSONDecoder()
                    let text = (response as? DecryptedValue)?.plainText
                    print(text)
                    if(text != "" && text != nil)
                    {
                        let data = text?.data(using: .utf8)
                        self.myMessages = try! decoder.decode([Message].self, from: data!)
                    }
                }
            }
        }
        allMessages = messages + myMessages
        allMessages.sort(by: { $0.date > $1.date })
    }
    
    func sendMessage(message: Message){
        messages.append(message)
        let encoder = JSONEncoder()
        let data = try! encoder.encode(myMessages)
        guard let dataMessages = String(data: data,encoding: .utf8) else { return }
        Blockstack.shared.putFile(to: "\(self.name).id.blockstack.json", text: dataMessages, sign: true, signingKey: nil){
            (publicUrl, error) in
            if(error != nil){
                print("put file error")
            }else{
                print("put file succes")
            }
        }
    }
    
    func update()
    {
        allMessages = messages + myMessages
        allMessages.sort(by: { $0.date > $1.date })
    }
    
    
}
