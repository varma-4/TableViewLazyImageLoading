//
//  ACModel.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

class ACModel: NSObject {

    var itemTitle: String?
    var itemDescription: String?
    var itemImageHref: String?

    override func setValuesForKeys(_ keyedValues: [String: Any]) {

        for keyValuePair in keyedValues {
            let itemKey = ACModelprefix + keyValuePair.key.capitalizingFirstLetter()
            let selector = NSSelectorFromString(itemKey)
            let responds = self.responds(to: selector)

            if !responds {
                continue
            }

            super.setValue(keyValuePair.value, forKey: keyValuePair.key)
        }
    }

    init(dictionary: [String: Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }

}

