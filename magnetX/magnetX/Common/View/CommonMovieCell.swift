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
    
    var model: CommonMovieModel? {
        willSet {
            if let posterPath = model?.poster_path {
                posterImgView.kf.setImage(with: URL(string: thumbnailUrl + posterPath))
            }
            
            if let rate = model?.vote_average {
                starView.value = CGFloat(Double(rate) ?? 0)
            }
            else {
                starView.value = 0
            }
            
            if let releaseData = model?.release_date {
                releaseDateLabel.text = "上映日期: " + releaseData
            }
            else {
                 releaseDateLabel.text = "上映日期: 暂无数据"
            }
            
            nameLabel.text = model?.title ?? "暂无数据"
            rateLabel.text = model?.vote_average ?? "暂无数据"
            overViewLabel.text = model?.overview ?? "暂无数据"
        }
    }
    
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
        
        fakeModel()
    }
    
    private func fakeModel() {
        let resource = URL(string: "https://image.tmdb.org/t/p/w500/3nCUY6Or2yXVnSfY5ctdMPoLa7B.jpg")
        posterImgView.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "ic_star_half"))
        nameLabel.text = "死侍2"
        starView.value = 4.5
        rateLabel.text = "4.5"
        releaseDateLabel.text = "上映日期: 2018-05-15"
        overViewLabel.text = "一位当代俄罗斯的美女间谍多米尼卡·叶戈罗娃（Dominika Egorova ）在不情愿的情况下被克格勃训练成为一名“燕子”（克格勃色情间谍的代号，男性称为乌鸦），之后被派去勾引一名美国的中情局特工内森尼尔·纳什（Nathaniel Nash）以获取美国打入俄罗斯内部的间谍名单。然而多米尼卡与纳什这两个年轻人却碰撞出了爱情的火花，之后多米尼卡为了报复那些把她训练成“燕子”的同僚，主动选择成为一名为中情局服务的双重间谍。在她的帮助下，俄罗斯安插在美国华盛顿和军方的高级间谍纷纷被揪了出来，而她也将排除万难，重回莫斯科，成为普京身边的美国眼线……"
    }
}
