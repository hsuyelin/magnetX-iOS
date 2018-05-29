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
    
    static func show(_ message: String? = nil, image: UIImage? = nil) {
        HUD.configure().shared.show(withMessage: message, image: image, isLoading: true)
    }
    
    static func dismiss() {
        KRProgressHUD.dismiss()
    }
    
    static func showInfo(_ info: String) {
        HUD.configure().showMessage(info)
    }
    
    static func showSuccess(_ message: String? = nil) {
        HUD.configure().set(deadlineTime: 1.8).showSuccess(withMessage: message)
    }
    
    static func showError(_ message: String? = nil) {
        HUD.configure().showError(withMessage: message)
    }
    
    static func showImage(_ image: UIImage, message: String?) {
        HUD.configure().showImage(image, message: message)
    }
    
    static func showNetworkError() {
        guard let isReachable = reachabilityManager?.isReachable, !isReachable else {
            HUD.showInfo("服务器异常")
            return
        }
        
//        KRProgressHUD.resetStyles().set(font: UIFont.systemFont(ofSize: 15)).set(deadlineTime: 1.8).set(style: .custom(background: UIColor.black.alpha(0.45), text: UIColor.white, icon: nil)).set(viewOffset: 240.rpx).set(cornerRadius: 25).set(maskType: .clear).showMessage("网络异常，请检查您的网络")
        
        KRProgressHUD.showMessage("网络异常，请检查您的网络")
    }
    
//    static func showSignInSuccess(_ image: UIImage) {
//        let mAttrText = NSMutableAttributedString(string: "签到成功，+5 积分")
//        mAttrText.addAttributes([.foregroundColor: UIColor(hex: "D4A443"), .font: UIFont.systemFont(ofSize: 18)], range: NSMakeRange(5, 2))
//        HUD.configure().set(contents: image.cgImage).set(size: CGSize(width: 240.wpx, height: 160.rpx)).set(font: UIFont.systemFont(ofSize: 16)).shared.show(withMessage: "", attributedText: mAttrText, isOnlyText: true)
//    }
}
