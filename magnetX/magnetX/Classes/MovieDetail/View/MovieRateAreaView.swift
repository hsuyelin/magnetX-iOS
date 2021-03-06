//
//  MovieRateAreaView.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/1.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

class MovieRateAreaView: UIView {
    
    private lazy var rateOrgLabel: UILabel = {
        let rateOrgLabel = UILabel()
        rateOrgLabel.textColor = UIColor(hex: "#BBBBBB")
        rateOrgLabel.font = UIFont.systemFont(ofSize: 8.rpx)
        rateOrgLabel.numberOfLines = 1
        return rateOrgLabel
    }()
    
    private lazy var rateValueLabel: UILabel = {
        let rateValueLabel = UILabel()
        rateValueLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)
        rateValueLabel.font = UIFont.systemFont(ofSize: 16.rpx)
        return rateValueLabel
    }()
    
    private lazy var starView: SwiftyStarRatingView = {
        let starView = SwiftyStarRatingView()
        starView.emptyStarImage = #imageLiteral(resourceName: "ic_star_empty")
        starView.halfStarImage = #imageLiteral(resourceName: "ic_star_half")
        starView.filledStarImage = #imageLiteral(resourceName: "ic_star_full")
        starView.isEnabled = false
        starView.spacing = 0.0
        return starView
    }()
    
    private lazy var rateCountLabel: UILabel = {
        let rateCountLabel = UILabel()
        rateCountLabel.textColor = UIColor.normal
        rateCountLabel.font = UIFont.systemFont(ofSize: 8.rpx)
        return rateCountLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        loadSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = UIColor.white
        self.layer.shadowOpacity = 0.25
        self.layer.shadowColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.cornerRadius = 1.0
    }
    
    private func loadSubviews() {
        addSubview(rateOrgLabel)
        addSubview(rateValueLabel)
        addSubview(starView)
        addSubview(rateCountLabel)
        
        rateOrgLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(8.rpx)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        rateValueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rateOrgLabel.snp.bottom).offset(3.rpx)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        starView.snp.makeConstraints { (make) in
            make.top.equalTo(rateValueLabel.snp.bottom)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: 48.rpx, height: 16.rpx))
        }
        
        rateCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(starView.snp.bottom)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}

extension MovieRateAreaView {
    func bindData(_ model: MovieDetailModel) {
        rateOrgLabel.text = "豆瓣评分"
        let rate: CGFloat = CGFloat(Double(model.rating.average) ?? 0)
        rateValueLabel.text = String.init(format: "%.1f", rate)
        starView.value = rate / 2.0
        rateCountLabel.text = !model.ratings_count.isBlank ? model.ratings_count : "0"
    }
}
