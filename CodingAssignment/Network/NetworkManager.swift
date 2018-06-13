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
        urlSession(with: urlString) { (data, _, error) in
            // Convert data to UTF8 data
            guard let dataString = String.init(data: data!, encoding: String.Encoding.isoLatin1), let utf8Data = dataString.data(using: String.Encoding.utf8) else {
                completion(nil, error)
                return
            }
            completion(utf8Data, error)
        }
    }
    
    func downloadImage(with urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void ) {
        
        urlSession(with: urlString) { (data, response, error) in
            guard let data = data, let urlResponse = response as? HTTPURLResponse else {
                completion(nil, nil)
                return
            }
            if urlResponse.statusCode == API_SUCCESS_CODE {
                completion(data, error)
                return
            }
            completion(nil, error)
        }
        
    }
    
    func urlSession(with urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, nil, nil)
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        // Set requestMethod to GET
        request.httpMethod = HTTP_REQUEST_GET
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error)  in
            completion(data, response, error)
        }
        task.resume()
    }
    
}


