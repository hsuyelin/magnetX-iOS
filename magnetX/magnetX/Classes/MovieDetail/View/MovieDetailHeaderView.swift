//
//  MovieDetailHeaderView.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/31.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

class MovieDetailHeaderView: UIView {
    
    private lazy var bgImgView: UIImageView =  {
        let bgImgView = UIImageView()
        bgImgView.image = #imageLiteral(resourceName: "img_poster_placeholder")
        return bgImgView
    }()
    
    private lazy var postImgView: UIImageView =  {
        let postImgView = UIImageView()
        return bgImgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubviews() {
        addSubview(bgImgView)
        addSubview(postImgView)
    }
}
