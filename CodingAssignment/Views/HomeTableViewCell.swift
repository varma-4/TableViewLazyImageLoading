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
        imageView.backgroundColor = .red
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    var itemTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = ""
        return label
    }()
    
    var itemDescription: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
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
        addSubview(itemImageView)
        addSubview(itemTitle)
        addSubview(itemDescription)
        
        setConstraints()
    }
    
    func setConstraints() {
        // ItemImageView Contraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10.0@1000-[v0(<=50)]-10.0@500-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemImageView]))
        
        // ItemTitleLabel Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:v0-10-[v1]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemImageView, "v1": itemTitle]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemTitle]))
        
        // ItemDescriptionLabel Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[v0]-10.0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": itemDescription]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-10.0@1000-[v1]->=10.0@750-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":itemTitle, "v1": itemDescription]))
    }
    
}
