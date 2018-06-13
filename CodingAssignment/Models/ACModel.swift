//
//  ACModel.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

struct ACModel: Codable {
    
    var itemTitle: String?
    var itemDescription: String?
    var imageString: String?
    
    private enum CodingKeys: String, CodingKey {
        case itemTitle = "title"
        case itemDescription = "description"
        case imageString = "imageHref"
    }
    
}

