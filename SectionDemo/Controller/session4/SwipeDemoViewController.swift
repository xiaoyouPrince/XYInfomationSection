//
//  SwipeDemoViewController.swift
//  SectionDemo
//
//  Created by 渠晓友 on 2023/5/25.
//  Copyright © 2023 渠晓友. All rights reserved.
//

import UIKit

class SwipeDemoViewController: XYInfomationBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContentWithData(DataTool.weiBoData(), itemConfig: { item in
            item.swipeConfig = XYInfomationItemSwipeConfig.standardDeleteAction
        }, sectionConfig: nil, sectionDistance: 10, contentEdgeInsets: .init(top: 10, left: 20, bottom: 34, right: 20)) { index, cell in
            SVProgressHUD.showInfo(withStatus: cell.model.title)
        }
    }
}


