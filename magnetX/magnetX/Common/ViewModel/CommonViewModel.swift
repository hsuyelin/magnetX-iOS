//
//  CommonViewModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/29.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
