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

extension UILabel {
    
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
    
}
