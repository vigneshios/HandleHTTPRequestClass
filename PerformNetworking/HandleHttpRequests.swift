//
//  HandleHttpRequests.swift
//  PerformNetworking
//
//  Created by Apple on 16/01/18.
//  Copyright © 2018 WowDreamapps. All rights reserved.
//

import Foundation

enum HttpMethod : String {
    case GET
    case POST
    case DELETE
    case PUT
    
}

class HandleHttpRequests: NSObject {
    var request : URLRequest?
    var session: URLSession?
    
    static func instance() -> HandleHttpRequests {
        return HandleHttpRequests()
    }
    
    func makeAPICall(url: String,params: Dictionary<String, Any>?, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
        request = URLRequest(url: URL(string: url)!)
        print("Used url ==> \(url)")
        if let params = params {
            let json = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request?.httpBody = json
        }
        request?.httpMethod = method.rawValue
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        session = URLSession(configuration: configuration)
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    success(data , response , error as NSError?)
                } else {
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                }
            }else {
                failure(data , response as? HTTPURLResponse, error as NSError?)
                
            }
            }.resume()
        
    }

        
        
        
    }

