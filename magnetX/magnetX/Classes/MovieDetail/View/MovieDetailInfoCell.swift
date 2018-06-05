//
//  MovieDetailInfoCell.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/1.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

class MovieDetailInfoCell: CommonTableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)
        nameLabel.font = UIFont.systemFont(ofSize: 18.rpx)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = NSTextAlignment.left
        return nameLabel
    }()
    
    private lazy var genresLabel: UILabel = {
        let genresLabel = UILabel()
        genresLabel.textColor = UIColor.normal
        genresLabel.font = UIFont.systemFont(ofSize: 10.rpx)
        genresLabel.numberOfLines = 1
        return genresLabel
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
    
    private lazy var totalTimeLabel: UILabel = {
        let totalTimeLabel = UILabel()
        totalTimeLabel.textColor = UIColor.normal
        totalTimeLabel.font = UIFont.systemFont(ofSize: 10.rpx)
        totalTimeLabel.numberOfLines = 1
        return totalTimeLabel
    }()
    
    lazy var rateView: MovieRateAreaView = {
        let rateView = MovieRateAreaView()
        return rateView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        loadSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(originalNameLabel)
        contentView.addSubview(releaseDateLabel)
//        contentView.addSubview(totalTimeLabel)
        contentView.addSubview(rateView)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(15.rpx)
            make.top.equalTo(contentView.snp.top).offset(15.rpx)
            make.width.equalTo(150.rpx)
        }
        
        genresLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10.rpx)
            make.left.equalTo(contentView.snp.left).offset(15.rpx)
        }
        
        originalNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genresLabel.snp.bottom).offset(2.rpx)
            make.left.equalTo(contentView.snp.left).offset(15.rpx)
        }
        
        releaseDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(originalNameLabel.snp.bottom).offset(2.rpx)
            make.left.equalTo(contentView.snp.left).offset(15.rpx)
        }
        
//        totalTimeLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(releaseDateLabel.snp.bottom).offset(2.rpx)
//            make.left.equalTo(contentView.snp.left).offset(15.rpx)
//        }
        
        rateView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(12.rpx)
            make.right.equalTo(contentView.snp.right).offset(-15.rpx)
            make.size.equalTo(CGSize(width: 70.rpx, height: 70.rpx))
        }
    }
}

extension MovieDetailInfoCell {
    func bindItem(_ model: MovieDetailModel) {
        nameLabel.text = !model.title.isBlank ? model.title : "暂无数据"
        genresLabel.text = model.yearAndGenres
        releaseDateLabel.text = "上映时间: " + (!model.year.isBlank ? model.year : "暂无数据")
        rateView.bindData(model)
    }
}
