//
//  StringExtension.swift
//  iWeeB
//
//  Created by 高翔 on 2017/12/13.
//  Copyright © 2017年 GaoX. All rights reserved.
//

import UIKit
import Foundation

extension String {
    public var isBlank: Bool {
        return isEmpty || trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    public var toMD5String: String {
        let str = cString(using: .utf8)
        var digest = [UInt8].init(repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(str, CC_LONG(strlen(str)), &digest)
        var output = String()
        for i in digest {
            output = output.appendingFormat("%02x", i)
        }
        return output
    }
}
