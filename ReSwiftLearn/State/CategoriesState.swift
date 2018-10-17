//
//  CategoriesState.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import ReSwift

enum Category:String {
    case pop = "Pop"
    case electronic = "Electronic"
    case rock = "Rock"
    case metal = "Metal"
    case rap = "Rap"
}

struct CategoriesState:StateType {
    let categories:[Category]
    var currentCategorySelected:Category
    init(currentCategory:Category) {
        categories = [.pop, .electronic, .rock, .metal, .rap]
        currentCategorySelected = currentCategory
    }
}
