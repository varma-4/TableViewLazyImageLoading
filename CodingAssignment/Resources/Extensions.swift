//
//  Extensions.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

extension StringProtocol {
    
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
