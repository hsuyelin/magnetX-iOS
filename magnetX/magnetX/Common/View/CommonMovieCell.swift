//
//  CommonMovieCell.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/28.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import Kingfisher

class CommonMovieCell: UITableViewCell {
    
    private lazy var posterImgView: UIImageView =  {
        let posterImgView = UIImageView()
        posterImgView.image = #imageLiteral(resourceName: "img_poster_placeholder")
        return posterImgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 15.rpx)
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
        starView.spacing = 0.0
        return starView
    }()
    
    private lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        rateLabel.font = UIFont.systemFont(ofSize: 12.rpx)
        rateLabel.textColor = UIColor.normal
        return rateLabel
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.font = UIFont.systemFont(ofSize: 12.rpx)
        releaseDateLabel.textColor = UIColor.normal
        return releaseDateLabel
    }()
    
    lazy var overViewLabel: UILabel = {
        let overViewLabel = UILabel()
        overViewLabel.font = UIFont.systemFont(ofSize: 12.rpx)
        overViewLabel.textColor = UIColor.normal
        overViewLabel.numberOfLines = 2
        return overViewLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
//        selectionStyle = .none
        loadSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubviews() {
        contentView.addSubview(posterImgView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(starView)
        contentView.addSubview(rateLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(overViewLabel)
        
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
        
        starView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5.rpx)
            make.left.equalTo(posterImgView.snp.right).offset(10.rpx)
            make.size.equalTo(CGSize(width: 75.rpx, height: 25.rpx))
        }
        
        rateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(starView.snp.right).offset(5.rpx)
            make.centerY.equalTo(starView.snp.centerY)
        }
        
        releaseDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(starView.snp.bottom).offset(5.rpx)
            make.left.equalTo(posterImgView.snp.right).offset(10.rpx)
        }
        
        overViewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(5.rpx)
            make.left.equalTo(posterImgView.snp.right).offset(10.rpx)
            make.right.equalToSuperview().offset(-10.rpx)
        }
    }
}

extension CommonMovieCell {
    
    func bindItem(_ model: CommonMovieModel) {
        if !model.poster_path.isBlank {
            posterImgView.kf.setImage(with: URL(string: thumbnailUrl + model.poster_path), placeholder:#imageLiteral(resourceName: "img_poster_loading_placeholder"))
        }
        
        let rate: CGFloat = CGFloat(Double(model.vote_average) ?? 0)
        starView.value = rate / 2.0
        rateLabel.text = String.init(format: "%.1f", rate)
        nameLabel.text = !model.title.isBlank ? model.title : "暂无数据"
        releaseDateLabel.text = "上映日期: " + (!model.release_date.isBlank ? model.release_date : "暂无数据")
        overViewLabel.text = "简介: " + (!model.overview.isBlank ? model.overview : "暂无数据")
    }
}
