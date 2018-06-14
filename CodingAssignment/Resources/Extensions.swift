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

extension UIImageView {
    
    func loadImageWithURL(urlString: String?) {
        
        guard let urlStringUnWrapped = urlString else {
            return
        }
        
        NetworkManager.sharedManager.downloadImage(with: urlStringUnWrapped) { (data, error) in
            guard let data = data, let imageDownloaded = UIImage.init(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = imageDownloaded
            }
            imageCache.setObject(imageDownloaded, forKey: urlStringUnWrapped as AnyObject)
        }
        
    }
}

extension UIView {
    
    func addMultipleConstraints(withVFLStrings arrayOfVFL: [String], dictionary: [String: Any]) {
        for eachString in arrayOfVFL {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: eachString, options: NSLayoutFormatOptions(), metrics: nil, views: dictionary))
        }
    }
    
}
