//
//  ViewController.swift
//  Oauth2.0_App
//
//  Created by HigherVisibility on 25/10/2018.
//  Copyright © 2018 ahmedHigherVisibility. All rights reserved.
//

import UIKit
import OAuthSwift
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

     var oauthswift: OAuth2Swift?
    let url = [URL]()
     var token = ""
    
    
    
    @IBAction func signAction(_ sender: Any) {
        
        self.oauthswift = OAuth2Swift(
            consumerKey:    "p1A-NyPjytudHqqDEzSl0ODw8-hT",
            consumerSecret: "92e4ff6c2044fa061871f11bfe92b79977a243cbc7bc8a783b292b55285b5c6a",
            authorizeUrl:   "https://api.sumup.com/authorize",
            accessTokenUrl: "https://api.sumup.com/token",
            responseType:   "code"
        )
        
        self.oauthswift!.allowMissingStateCheck = true
        
        guard let rwURL = URL(string: "oauth-swift://oauth-callback/sumup") else { return }
        
        //3
        self.oauthswift!.authorize(withCallbackURL: rwURL, scope: "", state: "", success: {
            (credential, response, parameters) in
            
            print("access token\(credential.oauthToken)")
            print("data saved to keychain \(credential.oauthToken)")
            self.token = credential.oauthToken
            
        }, failure: { (error) in
            print("alert\(error.localizedDescription)")
        })
    }
    
    
    @IBAction func Get_Responce(_ sender: Any) {
       
        self.oauthswift?.client.get("https://api.sumup.com/v0.1/me",
                              success: { response in
                                let dataString = response.string
                                print(dataString)
              let json = JSON(dataString)
                       
                let name = json["username"].stringValue
                                
                                print("User Name \(name)")
                                
        },
                              failure: { error in
                                print(error)
        }
        )
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

