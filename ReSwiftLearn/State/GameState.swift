//
//  GameState.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/18.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import ReSwift

struct MemoryCard {
    let imageUrl:String
    var isFilpped:Bool
    var isAlreadyGussed:Bool
}

struct GameState:StateType {
    var memoryCards:[MemoryCard]
    var showLoading:Bool
    var gameFinshed:Bool
}
