//
//  AppReducer.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action:Action, state:AppState?) -> AppState {
    return AppState(
        routingState: routingReducer(action: action, state: state?.routingState),
        menuState:menuReducer(action: action, state: state?.menuState)
    )
}
