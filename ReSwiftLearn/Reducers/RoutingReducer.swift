//
//  RoutingReducer.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import ReSwift

func routingReducer(action:Action, state:RoutingState?) -> RoutingState {
    var state = state ?? RoutingState()
    switch action {
    case let routingAction as RoutingAction:
        state.navigationState = routingAction.destination
    default:
        break
    }
    return state
}
