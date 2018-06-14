//
//  HomeTableViewCell.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleToFill
        return imageView
    }()
    
    var itemTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = ""
        return label
    }()
    
    var itemDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = ""
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        // Add Custom Views to TableViewCell
        addSubview(itemImageView)
        addSubview(itemTitle)
        addSubview(itemDescription)
        // Assign Constraints for the Views
        setConstraints()
    }
    
    func setConstraints() {
        // ItemImageView Contraints
        let dictionary = ["imageView": itemImageView, "title": itemTitle, "desc": itemDescription]
        addMultipleConstraints(withVFLStrings: ["|-10.0-[imageView(80)]", "V:|-10.0@1000-[imageView(<=80)]-10.0@500-|"], dictionary: dictionary)
        
        // ItemTitleLabel Constraints
        addMultipleConstraints(withVFLStrings: ["[imageView]-10.0-[title]-10.0-|", "V:|-10.0@1000-[title]"], dictionary: dictionary)
        
        // ItemDescriptionLabel Constraints
        addMultipleConstraints(withVFLStrings: ["[imageView]-10-[desc]-10.0-|", "V:[title]-10.0@1000-[desc]->=10.0@750-|"], dictionary: dictionary)
        
    }
    
}
