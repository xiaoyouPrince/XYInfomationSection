//
//  PersonInfoHeaderCell.swift
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/10.
//  Copyright © 2021 渠晓友. All rights reserved.
//

import UIKit

class PersonInfoHeaderCell: XYInfomationCell {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageWH: CGFloat = 150
        imageView.frame = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
        imageView.center = CGPoint(x: self.center.x, y: self.center.y - 20)
        
        titleLabel.sizeToFit()
        titleLabel.center = imageView.center
        titleLabel.center.y += imageView.frame.size.height/2 + 20
    }
    
    override var model: XYInfomationItem{
        didSet{
            imageView.image = UIImage.init(named: model.imageName)
            titleLabel.text = model.title
        }
    }
}
