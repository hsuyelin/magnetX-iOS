//
//  PixelExtension.swift
//  ChengTayTong
//
//  Created by GorXion on 2018/2/9.
//  Copyright © 2018年 adinnet. All rights reserved.
//

import UIKit
import Foundation

private let IS_IPHONE5 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 1136).equalTo((UIScreen.main.currentMode?.size)!) : false)
private let IS_IPHONE6 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 750, height: 1334).equalTo((UIScreen.main.currentMode?.size)!) : false)

private let scaleW = UIScreen.main.bounds.width / 375.0

extension Int {
    public var rpx: CGFloat {
        if IS_IPHONE5 {
            return CGFloat(self) * 0.84
        }
        else if IS_IPHONE6 {
            return CGFloat(self)
        }
        return CGFloat(self) * 1.104
    }
    
    public var wpx: CGFloat {
        return CGFloat(self) * scaleW
    }
}

extension Double {
    public var rpx: CGFloat {
        if IS_IPHONE5 {
            return CGFloat(self * 0.84)
        }
        else if IS_IPHONE6 {
            return CGFloat(self)
        }
        return CGFloat(self * 1.104)
    }
    
    public var wpx: CGFloat {
        return CGFloat(self) * scaleW
    }
}

extension CGFloat {
    public var rpx: CGFloat {
        if IS_IPHONE5 {
            return self * 0.84
        }
        else if IS_IPHONE6 {
            return self
        }
        return self * 1.104
    }
    
    public var wpx: CGFloat {
        return self * scaleW
    }
}
