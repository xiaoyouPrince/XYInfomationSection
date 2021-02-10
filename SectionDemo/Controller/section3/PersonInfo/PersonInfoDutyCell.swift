//
//  PersonInfoDutyCell.swift
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/10.
//  Copyright © 2021 渠晓友. All rights reserved.
//

import UIKit

class DutyButton: UIView{
    
    let handleSelectedNotificationName = NSNotification.Name(rawValue: "handleSelectedNotificationName")

    let titleColor_default = UIColor.systemGray //init(hex: "6B6D73")
    let titleColor_selected = UIColor.brown
    
    fileprivate var titleColor: UIColor?
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.textColor = titleColor_default
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    var selected: Bool {
        set{
            if newValue == true {
                titleColor = titleColor_selected
                
                titleLabel.textColor = titleColor
                layer.borderColor = titleColor!.cgColor
            }else{
                titleColor = titleColor_default
                
                titleLabel.textColor = titleColor
                layer.borderColor = titleColor!.cgColor
            }
        }
        get{
            return titleColor == titleColor_selected
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        titleLabel.text = title
        layer.cornerRadius = 5
        layer.borderWidth = 1
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSelected), name: handleSelectedNotificationName, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.sizeToFit()
        titleLabel.frame.origin.x = 20
        titleLabel.center.y = self.frame.size.height/2
    }
    
    @objc func tapAction(){
        if !selected {
            NotificationCenter.default.post(name: handleSelectedNotificationName, object: nil)
            selected = !selected
        }
    }
    
    @objc func handleSelected(){
        selected = false
    }
}

class PersonInfoDutyCell: XYInfomationCell {
    
    var HR: DutyButton = DutyButton(title: "")
    var BOSS: DutyButton = DutyButton(title: "")

    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        // HR/HRBP
        self.HR = DutyButton(title: "HR/HRBP")
        addSubview(HR)
        
        // BOSS/主管/员工
        self.BOSS = DutyButton(title: "BOSS/主管/员工")
        addSubview(BOSS)
        
        // subviews
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 23.0
        titleLabel.frame = CGRect(x: margin, y: margin, width: self.bounds.size.width - 2*margin, height: titleLabel.bounds.size.height)
        
        HR.frame.origin.x = titleLabel.frame.origin.x
        HR.frame.origin.y = titleLabel.frame.maxY + 15
        HR.frame.size = CGSize(width: UIScreen.main.bounds.size.width/2 - 40, height: 75)
        
        BOSS.frame.origin.x = HR.frame.maxX + 20
        BOSS.frame.origin.y = HR.frame.origin.y
        BOSS.frame.size = CGSize(width: UIScreen.main.bounds.size.width/2 - 40, height: 75)
    }
    
    override var model: XYInfomationItem{
        didSet{
            titleLabel.text = model.title
            titleLabel.sizeToFit()
            
            if model.value == "HR" {
                self.HR.selected = true
                self.BOSS.selected = false
            }
            
            if model.value == "BOSS" {
                self.HR.selected = false
                self.BOSS.selected = true
            }
        }
    }

}
