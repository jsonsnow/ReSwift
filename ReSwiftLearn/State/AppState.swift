//
//  AppState.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import ReSwift

struct AppState:StateType {
    let routingState:RoutingState
    let menuState:MenuState
    let categoriesState: CategoriesState
}
