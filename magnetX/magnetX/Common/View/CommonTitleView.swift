//
//  CommonTitleView.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/5.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

class CommonTitleView: UIButton {
    
    private var title: String?
    private var iconImgName: String?
    
    convenience init(frame: CGRect, title: String?, iconImgName: String?) {
        self.init(frame: CGRect.zero)
        
        self.title = title
        self.iconImgName = iconImgName
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.width - 100.rpx, height: 44.rpx))
        loadSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubviews() {
        
    }
}
