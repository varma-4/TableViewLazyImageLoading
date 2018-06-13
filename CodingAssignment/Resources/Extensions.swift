//
//  Extensions.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

// Caching images to make not download the image 
let imageCache = NSCache<AnyObject, AnyObject>()

extension StringProtocol {
    
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}

extension UIImageView {
    
    func loadImageWithURL(urlString:String) {
        let url = URL(string: urlString)
        image = nil
        
        if let imageCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print("error")
                return
            }
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data: data!)
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                self.image = imageToCache
            })
        }).resume()
        
    }
}
