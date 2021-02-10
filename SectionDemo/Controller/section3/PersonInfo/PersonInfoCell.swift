//
//  PersonInfoCell.swift
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/10.
//  Copyright © 2021 渠晓友. All rights reserved.
//

import UIKit

class PersonInfoCell: XYInfomationCell {
    
    let titleLabel = UILabel()
    let descLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        descLabel.font = UIFont.boldSystemFont(ofSize: 18)
        descLabel.textColor = .brown
        
        // subviews
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 23.0
        titleLabel.frame = CGRect(x: margin, y: margin, width: self.bounds.size.width - 2*margin, height: titleLabel.bounds.size.height)
        descLabel.frame = CGRect(x: margin, y: 2*margin + titleLabel.bounds.size.height, width: self.bounds.size.width - 2*margin, height: descLabel.bounds.size.height)
    }
    
    override var model: XYInfomationItem{
        didSet{
            titleLabel.text = model.title
            descLabel.text = model.value
            
            titleLabel.sizeToFit()
            descLabel.sizeToFit()
        }
    }
}
