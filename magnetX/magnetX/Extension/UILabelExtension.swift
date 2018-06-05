//
//  UILabelExtension.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/4.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

extension UILabel {
    public func changeLineSpace(lineSpace: CGFloat) {
        if self.text?.isBlank == true { return }
        let labelText = self.text ?? ""
        let attrStr = NSMutableAttributedString.init(string: labelText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attrStr.addAttributes([.paragraphStyle: paragraphStyle], range: NSMakeRange(0, labelText.count))
        self.attributedText = attrStr
    }
    
    public func changeWordSpace(wordSpace: CGFloat) {
        if self.text?.isBlank == true { return }
        let labelText = self.text ?? ""
        let attrStr = NSMutableAttributedString.init(string: labelText)
        attrStr.addAttributes([.kern : wordSpace], range: NSMakeRange(0, labelText.count))
        self.attributedText = attrStr
    }
    
    public func changeSpace(lineSpace: CGFloat, wordSpace: CGFloat) {
        if self.text?.isBlank == true { return }
        let labelText = self.text ?? ""
        let attrStr = NSMutableAttributedString.init(string: labelText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attrStr.addAttributes([.paragraphStyle: paragraphStyle], range: NSMakeRange(0, labelText.count))
        attrStr.addAttributes([.kern : wordSpace], range: NSMakeRange(0, labelText.count))
        self.attributedText = attrStr
    }
}
