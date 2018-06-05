//
//  MovieDetailOverViewCell.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/4.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

class MovieDetailOverViewCell: CommonTableViewCell {
    
    var didClickExpandHandler: ((CGFloat) -> Void)?
    
    private lazy var contentHeight: CGFloat = {
        let contentHeight = 0.rpx
        return contentHeight
    }()
    
    private lazy var overViewLabel: YYLabel = {
        let overViewLabel = YYLabel()
        overViewLabel.font = UIFont.systemFont(ofSize: 15.rpx)
        overViewLabel.numberOfLines = 0
        overViewLabel.isUserInteractionEnabled = true
        overViewLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        return overViewLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        loadSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSubviews() {
        contentView.addSubview(overViewLabel)
        
        overViewLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(15.rpx, 15.rpx, 15.rpx, 15.rpx))
        }
    }
    
    func configContent(content: String) {
        let attrStr = NSMutableAttributedString()
        attrStr.append(NSMutableAttributedString.init(string: content))
        attrStr.yy_font = UIFont.systemFont(ofSize: 15.rpx)
        attrStr.yy_setColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8), range: NSMakeRange(0, content.count))
        attrStr.yy_lineSpacing = 4.0
        overViewLabel.attributedText = attrStr
        let contentRect: CGRect = attrStr.boundingRect(with: CGSize(width: UIScreen.width - 15.rpx * 2, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil)
        contentHeight = ceil(contentRect.size.height) + 15.rpx * 2
    }
    
    func addMoreAction() {
        let moreAttr = NSMutableAttributedString.init(string: "... 展开")
        let highlightPart = YYTextHighlight()
        highlightPart.tapAction = ({[weak self] containerView, text, range, rect in
            if let strongSelf = self {
                let autoFitLabel: YYLabel = strongSelf.overViewLabel
                autoFitLabel.sizeToFit()
                strongSelf.didClickExpandHandler.map({
                    $0(strongSelf.contentHeight)
                })
            }
        })
        moreAttr.yy_setColor(UIColor(hex: "#38AE47"), range: "".nsRange(from: moreAttr.string.range(of: " 展开")!))
        moreAttr.yy_setTextHighlight(highlightPart, range: "".nsRange(from: moreAttr.string.range(of: " 展开")!))
        moreAttr.yy_font = overViewLabel.font
        
        let viewMoreLabel = YYLabel()
        viewMoreLabel.attributedText = moreAttr
        
        viewMoreLabel.numberOfLines = 0
        viewMoreLabel.sizeToFit()
        let truncationToken = NSAttributedString.yy_attachmentString(withContent: viewMoreLabel, contentMode: .center, attachmentSize: viewMoreLabel.frame.size, alignTo: moreAttr.yy_font ?? UIFont.systemFont(ofSize: 15.rpx), alignment: YYTextVerticalAlignment.center)
        overViewLabel.truncationToken = truncationToken
    }
}

extension MovieDetailOverViewCell {
    
    func bindItem(_ model: MovieDetailModel) {
        let content = !model.summary.isBlank ? model.summary : "暂无简介"
        configContent(content: content)
        addMoreAction()
    }
}
