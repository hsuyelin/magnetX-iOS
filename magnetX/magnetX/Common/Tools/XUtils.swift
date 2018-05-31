//
//  XUtils.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/25.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

class XUtils {
    static func getCurrentLanguage() -> String {
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return en_US
        case "zh-Hans-US", "zh-Hans-CN", "zh-Hant-CN", "zh-TW", "zh-HK", "zh-Hans":
            return zh_CN
        default:
            return zh_CN
        }
    }
    
    static func getCurrentRegion() -> String {
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return "US"
        case "zh-Hans-US", "zh-Hans-CN", "zh-Hant-CN", "zh-TW", "zh-HK", "zh-Hans":
            return "CN"
        default:
            return "CN"
        }
    }
}

public let YL_IS_IPHONEX = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125, height:2436), (UIScreen.main.currentMode?.size)!) : false

public let yl_statusBarHeight = UIApplication.shared.statusBarFrame.size.height
public let yl_navHeight = 44.0
public let yl_navWithStatusBarHeight = yl_statusBarHeight + CGFloat(yl_navHeight)


