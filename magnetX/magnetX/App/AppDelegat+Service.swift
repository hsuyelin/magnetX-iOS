//
//  AppDelegat+Service.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/24.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import RxSwiftX
import Moya

extension AppDelegate {
    func registerServices() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        NetworkService.configService()
    }
}
