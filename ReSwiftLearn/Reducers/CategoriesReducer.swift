//
//  CategoriesReducer.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import ReSwift

private struct CategoriesReducerConstants {
    static let userDefaultsCategoryKey = "currentCategoryKey"
}

private typealias C = CategoriesReducerConstants

func categoriesReducer(action:Action, state: CategoriesState?) -> CategoriesState {
    var currentCategory:Category = .pop
    if let loadedCategory = getCurrentCategoryStateFromUserDefaults() {
        currentCategory = loadedCategory
    }
    var state = state ?? CategoriesState(currentCategory: currentCategory)
    switch action {
    case let changeCategoryAction as ChangeCategoryAction:
        let newCategory = state.categories[changeCategoryAction.categoryIndex]
        state.currentCategorySelected = newCategory
        saveCurrentCategoryStateToUserDefaults(category: newCategory)
    default:
        break
    }
    return state
}

private func getCurrentCategoryStateFromUserDefaults() -> Category? {
    let userDefaults = UserDefaults.standard
    let rawValue = userDefaults.string(forKey: C.userDefaultsCategoryKey)
    if let rawValue = rawValue {
        return Category(rawValue: rawValue)
    } else {
        return nil
    }
}

private func saveCurrentCategoryStateToUserDefaults(category:Category) {
    let userDefaults = UserDefaults.standard
    userDefaults.set(category.rawValue, forKey: C.userDefaultsCategoryKey)
    userDefaults.synchronize()
}
