//
//  BlockstackFunction.swift
//  ProjetIOS
//
//  Created by Florian Fizaine on 10/01/2020.
//  Copyright © 2020 Florian Fizaine. All rights reserved.
//

import Foundation
import Blockstack
class BlockstackFunction {
    init() {
        
    }
    private func getFile(file: String) -> String
    {
        var rep = ""
        Blockstack.shared.getFile(at: file, verify: true) { response, error in
        if error != nil {
            print("get file error")
        } else {
            rep = (response as? DecryptedValue)?.plainText ?? "Invalid content"
            print("get file success \(rep)")
        }
        }
        return rep
    }
    
    private func putFile(file: String, data: String)
    {
        Blockstack.shared.putFile(to: file, text: data, sign: true, signingKey: nil){
            (publicURL, error) in
            if error != nil {
                print("put file error")
            }
            else
            {
                print("put file success \(publicURL ?? "na")")
            }
        }
    }
    
    private func codeco()
    {
        if Blockstack.shared.isUserSignedIn(){
            print("deja connecté -> deconnection")
            Blockstack.shared.signUserOut()
        }
        else {
            print("Non connecté -> connection")
            Blockstack.shared.signIn(redirectURI: URL(string: "https://heuristic-brown-7a88f8.netlify.com/redirect.html")!,
            appDomain: URL(string: "https://heuristic-brown-7a88f8.netlify.com")!) { authResult in
               switch authResult {
               case .success(let userData):
                   print("Sign in SUCCESS", userData.profile?.name as Any)
               case .cancelled:
                   print("Sign in CANCELLED")
               case .failed(let error):
                   print("Sign in FAILED, error: ", error ?? "n/a")
               }
            }
        }
    }
}
