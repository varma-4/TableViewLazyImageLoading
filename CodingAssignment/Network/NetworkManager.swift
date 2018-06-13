//
//  NetworkManager.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let sharedManager = NetworkManager()
    
    func fetchJSONData(from urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        //If URL is empty passing back nil values
        guard let url = URL(string: urlString) else {
            completion(nil, nil)
            return
        }
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url)
        // Set requestMethod
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest) { (data, _ , error)  in
            // Convert data to UTF8 data
            guard let dataString = String.init(data: data!, encoding: String.Encoding.isoLatin1), let utf8Data = dataString.data(using: String.Encoding.utf8) else {
                completion(nil, error)
                return
            }
            completion(utf8Data, error)
        }
        task.resume()
        
    }
    
    func downloadImage(with urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void ) {
        guard let url = URL(string: urlString) else {
            completion(nil, nil)
            return
        }
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url)
        // Set requestMethod
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error)  in
            guard let data = data, let urlResponse = response as? HTTPURLResponse else {
                completion(nil, nil)
                return
            }
            if urlResponse.statusCode == 200 {
                completion(data, error)
                return
            }
            completion(nil, error)
        }
        task.resume()
        
    }
    
}


