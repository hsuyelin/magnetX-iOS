//
//  BounceTabBar.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/28.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit

class BounceTabBar: UITabBar {
    override func layoutSubviews() {
        
        super.layoutSubviews()
        for tabBarButton in subviews {
            if NSStringFromClass(tabBarButton.classForCoder) == "UITabBarButton" {
                let ctr = tabBarButton as! UIControl
                ctr.addTarget(self, action: #selector(self.barButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            }
        }
    }
    
    @objc private func barButtonAction(sender:UIControl)  {
        for imageView in sender.subviews {
            if NSStringFromClass(imageView.classForCoder) == "UITabBarSwappableImageView" {
                self.playAnimation(view: imageView)
            }
        }
    }
    
    @objc private func playAnimation(view: UIView){
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.10, 0.9, 1.08, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.5)
        bounceAnimation.calculationMode = kCAAnimationCubic
        view.layer.add(bounceAnimation, forKey: nil)
    }
}
