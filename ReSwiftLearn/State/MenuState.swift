//
//  MenuState.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import ReSwift

struct MenuState: StateType {
    var menuTitles:[String]
    init() {
        menuTitles = ["New game","Choose Category"]
    }
}
