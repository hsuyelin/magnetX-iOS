//
//  UIColorExtension.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/24.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(hex string: String) {
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        guard hex.count == 3 || hex.count == 6 else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
    }
    
    public func alpha(_ value: CGFloat) -> UIColor {
        return withAlphaComponent(value)
    }
    
    /// #4381E8
    class var global: UIColor {
        return UIColor(hex: "#2C2D31")
    }
    
    /// #858585
    class var normal: UIColor {
        return UIColor(hex: "#858585")
    }
    
    /// #383838
    class var selected: UIColor {
        return UIColor(hex: "#383838")
    }
}