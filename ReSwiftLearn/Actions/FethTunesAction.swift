//
//  FethTunesAction.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/31.
//  Copyright © 2018 chen liang. All rights reserved.
//

import Foundation
import ReSwift

func fetchTunes(state: AppState, store: Store<AppState>) -> FetchTunesAction {
    
    ItunesApi.searchFor(category: state.categoriesState.currentCategorySelected.rawValue) { urls in
        store.dispatch(SetCardsAction(cardImageUrls: urls))
        
    }
    return FetchTunesAction()
}

struct FetchTunesAction:Action {
    
}
