//
//  UIImageExtension.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/25.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit

extension UIImage {
    public var originalImage: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
}

