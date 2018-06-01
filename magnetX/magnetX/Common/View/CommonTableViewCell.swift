//
//  CommonCell.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/1.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

class CommonTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        let customSelectionColorView = UIView()
        customSelectionColorView.backgroundColor = UIColor.cellHighlightedColor
        self.selectedBackgroundView = customSelectionColorView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
