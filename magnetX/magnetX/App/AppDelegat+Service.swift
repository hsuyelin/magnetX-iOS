//
//  AppDelegat+Service.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/24.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

extension AppDelegate {
    func registerServices() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
