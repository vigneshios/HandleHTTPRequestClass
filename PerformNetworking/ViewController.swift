//
//  ViewController.swift
//  PerformNetworking
//
//  Created by Apple on 16/01/18.
//  Copyright © 2018 WowDreamapps. All rights reserved.
//

import UIKit

class NetworkingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       self.performNetworkRequests()
        self.postRequestMethod()
     
    }
    
    
    func postRequestMethod() {
        
        let myPostUrl = "https://jsonplaceholder.typicode.com/posts"
        var paramDictionary = [String:Any]()
        paramDictionary["username"] = "vigg"
        paramDictionary["post"] = "Latest offer: Buy one jean and get 2 underwears free..No holes barred! Rush- In. "
        
        HandleHttpRequests.instance().makeAPICall(url: myPostUrl, params: paramDictionary, method: .POST, success: { (data, response, errpr) in
            //Api is successful
            print(paramDictionary)
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print(json)
                }catch {
                    print(error)
                }
            }
            
            
        }) { (data, res, err) in
            //Api failure
            print("Api failed")
        }
        
    }
    

    func performNetworkRequests() {
        
        let myGetUrl = "https://jsonplaceholder.typicode.com/users"
        HandleHttpRequests.instance().makeAPICall(url: myGetUrl, params: nil, method: .GET, success: { (data, res, err) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    print(json)
                }catch {
                    print(error)
                }
            }
        }) { (data, res, err) in
            print("Not able to fetch results")
        }
    }

}

