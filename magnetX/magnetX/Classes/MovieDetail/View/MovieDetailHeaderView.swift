//
//  MovieDetailHeaderView.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/31.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation
import ColorThiefSwift

class MovieDetailHeaderView: UIView {
    
    private lazy var postImgView: UIImageView =  {
        let postImgView = UIImageView()
        return postImgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubviews() {
        addSubview(postImgView)
        
        postImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-20.0)
            make.size.equalTo(CGSize(width: UIScreen.width / 2.0, height: UIScreen.width / 2.0 / 2.0 * 3.0))
        }
        
        postImgView.layer.shadowOpacity = 0.25
        postImgView.layer.shadowColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8).cgColor
        postImgView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    func loadPosterImage(image: UIImage?) {
        if image == nil {
            return
        }
        else {
            guard let dominantColor = ColorThief.getColor(from: image!) else {
                return
            }
            postImgView.image = image
            self.backgroundColor = dominantColor.makeUIColor()
        }
    }
}
