//
//  HotMovieCell.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/5.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Kingfisher

class HotMovieCell: CommonTableViewCell {
    
    private lazy var posterImgView: UIImageView =  {
        let posterImgView = UIImageView()
        posterImgView.image = #imageLiteral(resourceName: "img_poster_placeholder")
        return posterImgView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 17.rpx)
        nameLabel.textColor = UIColor.black
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    private lazy var starView: SwiftyStarRatingView = {
        let starView = SwiftyStarRatingView()
        starView.emptyStarImage = #imageLiteral(resourceName: "ic_star_empty")
        starView.halfStarImage = #imageLiteral(resourceName: "ic_star_half")
        starView.filledStarImage = #imageLiteral(resourceName: "ic_star_full")
        starView.isEnabled = false
        starView.spacing = 1.0
        return starView
    }()
    
    private lazy var noRateLabel: UILabel = {
        let noRateLabel = UILabel()
        noRateLabel.font = UIFont.systemFont(ofSize: 12.rpx)
        noRateLabel.textColor = UIColor(hex: "#959595")
        noRateLabel.text = "暂无评分"
        noRateLabel.isHidden = true
        return noRateLabel
    }()
    
    private lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        rateLabel.font = UIFont.systemFont(ofSize: 12.rpx)
        rateLabel.textColor = UIColor(hex: "#959595")
        return rateLabel
    }()
    
    private lazy var directorLabel: UILabel = {
        let directorLabel = UILabel()
        directorLabel.font = UIFont.systemFont(ofSize: 12.rpx)
        directorLabel.textColor = UIColor(hex: "#959595")
        return directorLabel
    }()
    
    private lazy var castsLabel: UILabel = {
        let castsLabel = UILabel()
        castsLabel.font = UIFont.systemFont(ofSize: 12.rpx)
        castsLabel.textColor = UIColor(hex: "#959595")
        castsLabel.numberOfLines = 2
        return castsLabel
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
        contentView.addSubview(posterImgView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(noRateLabel)
        contentView.addSubview(starView)
        contentView.addSubview(rateLabel)
        contentView.addSubview(directorLabel)
        contentView.addSubview(castsLabel)
        
        posterImgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10.rpx)
            make.top.equalToSuperview().offset(10.rpx)
            make.size.equalTo(CGSize(width: 60.rpx, height: 90.rpx))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(posterImgView.snp.top)
            make.left.equalTo(posterImgView.snp.right).offset(10.rpx)
            make.right.equalToSuperview().offset(-10.rpx)
        }
        
        noRateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5.rpx)
            make.left.equalTo(posterImgView.snp.right).offset(10.rpx)
            //            make.size.equalTo(CGSize(width: 57.rpx, height: 19.rpx))
        }
        
        starView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalTo(posterImgView.snp.right).offset(10.rpx)
            make.size.equalTo(CGSize(width: 57.rpx, height: 19.rpx))
        }
        
        rateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(starView.snp.right).offset(5.rpx)
            make.centerY.equalTo(starView.snp.centerY)
        }
        
        directorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(starView.snp.bottom).offset(5.rpx)
            make.left.equalTo(posterImgView.snp.right).offset(10.rpx)
        }
        
        castsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(directorLabel.snp.bottom).offset(5.rpx)
            make.left.equalTo(posterImgView.snp.right).offset(10.rpx)
            make.right.equalToSuperview().offset(-10.rpx)
        }
    }
}

extension HotMovieCell {
    
    func bindItem(_ model: HotMovieModel) {
        if model.images.medium.isBlank == false {
            posterImgView.kf.setImage(with: URL(string: model.images.medium), placeholder:#imageLiteral(resourceName: "img_poster_loading_placeholder"))
        }
        
        let stars: CGFloat = CGFloat(Double(model.rating.stars) ?? 0)
        let rate: CGFloat = CGFloat(Double(model.rating.average) ?? 0)
        noRateLabel.isHidden = stars > 0
        starView.isHidden = !noRateLabel.isHidden
        rateLabel.isHidden = !noRateLabel.isHidden
        starView.value = rate / 2.0
        rateLabel.text = String.init(format: "%.1f", rate)
        
        nameLabel.text = model.title.isBlank == false ? model.title : "暂无数据"
        directorLabel.text = "导演: " + model.director
        castsLabel.text = "主演: " + model.cast
        
        directorLabel.changeLineSpace(lineSpace: 2.0)
        castsLabel.changeLineSpace(lineSpace: 2.0)
    }
}
