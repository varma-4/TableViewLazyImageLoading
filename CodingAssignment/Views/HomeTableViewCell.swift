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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
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
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-10.0-[v0(60)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10.0@1000-[v0(<=60)]-10.0@500-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemImageView]))
        
        // ItemTitleLabel Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[v0]-10.0-[v1]-10.0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemImageView, "v1": itemTitle]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10.0@1000-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemTitle]))
        
        // ItemDescriptionLabel Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[v1]-10-[v0]-10.0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": itemDescription, "v1": itemImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-10.0@1000-[v1]->=10.0@750-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemTitle, "v1": itemDescription]))
    }
    
}
