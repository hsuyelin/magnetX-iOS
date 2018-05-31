//
//  HUD.swift
//  ChengTayTong
//
//  Created by GorXion on 2018/2/8.
//  Copyright © 2018年 adinnet. All rights reserved.
//

import Alamofire

final class HUD {
    
    static let reachabilityManager = NetworkReachabilityManager()
    
    @discardableResult
    static func configure() -> KRProgressHUD.Type {
        KRProgressHUD.resetStyles().set(font: UIFont.systemFont(ofSize: 15)).set(style: KRProgressHUDStyle.black).set(cornerRadius: 5).set(activityIndicatorViewStyle: KRActivityIndicatorViewStyle.color(UIColor.init(white: 1.0, alpha: 0.8)))
        return KRProgressHUD.self
    }
    
    static func show(message: String? = nil, image: UIImage? = nil) {
        HUD.configure().shared.show(withMessage: message, image: image, isLoading: true)
    }
    
    static func dismiss() {
        KRProgressHUD.dismiss()
    }
    
    static func showInfo(info: String) {
        HUD.configure().showMessage(info)
    }
    
    static func showSuccess(message: String? = nil) {
        HUD.configure().set(deadlineTime: 1.8).showSuccess(withMessage: message)
    }
    
    static func showError(message: String? = nil) {
        HUD.configure().showError(withMessage: message)
    }
    
    static func showImage(image: UIImage, message: String?) {
        HUD.configure().showImage(image, message: message)
    }
    
    static func showNetworkError() {
        guard let isReachable = reachabilityManager?.isReachable, !isReachable else {
            HUD.showInfo(info: "服务器异常")
            return
        }
        
        KRProgressHUD.showMessage("网络异常，请检查您的网络")
    }
}
