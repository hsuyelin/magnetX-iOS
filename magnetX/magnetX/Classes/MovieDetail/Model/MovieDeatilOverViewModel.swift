//
//  MovieDeatilOverViewModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/4.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

struct MovieDetailOverViewModel: Codable {
    var isExpanded: Bool
    var content: String
    var contentHeight: CGFloat
    
    init(isExpanded: Bool, content: String, contentHeight: CGFloat) {
        self.isExpanded = isExpanded
        self.content = content
        self.contentHeight = contentHeight
    }
}
