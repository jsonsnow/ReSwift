//
//  RoutingState.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import ReSwift

struct RoutingState:StateType {
    var navigationState:RoutingDestination
    
    init(navigationState:RoutingDestination = .menu) {
        self.navigationState = navigationState
    }
}
