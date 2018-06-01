//
//  MovieDetailInfoCell.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/1.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

class MovieDetailInfoCell: CommonMovieCell {
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)
        nameLabel.font = UIFont.systemFont(ofSize: 18.rpx)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = NSTextAlignment.left
        return nameLabel
    }()
    
    private lazy var hotLevelLabel: UILabel = {
        let hotLevelLabel = UILabel()
        hotLevelLabel.textColor = UIColor.normal
        hotLevelLabel.font = UIFont.systemFont(ofSize: 10.rpx)
        hotLevelLabel.numberOfLines = 1
        return hotLevelLabel
    }()
    
    private lazy var originalNameLabel: UILabel = {
        let originalNameLabel = UILabel()
        originalNameLabel.textColor = UIColor.normal
        originalNameLabel.font = UIFont.systemFont(ofSize: 10.rpx)
        originalNameLabel.numberOfLines = 1
        return originalNameLabel
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.textColor = UIColor.normal
        releaseDateLabel.font = UIFont.systemFont(ofSize: 10.rpx)
        releaseDateLabel.numberOfLines = 1
        return releaseDateLabel
    }()
}
