//
//  PersonInfoController.swift
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/10.
//  Copyright © 2021 渠晓友. All rights reserved.
//

import UIKit

class PersonInfoController: XYInfomationBaseViewController {
    
    // MARK: - 两部分：头像 + 内容
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color: CGFloat = 0.95
        self.view.backgroundColor = UIColor(red: color, green: color, blue: color, alpha: 1)
        self.setContentWithData(DataTool.customData(), itemConfig: nil, sectionConfig: { (section) in
            section.layer.cornerRadius = 0
        }, sectionDistance: 10, contentEdgeInsets: .zero) { (index, cell) in
            print(cell.model.title)
        }
    }
}
