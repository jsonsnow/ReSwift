//
//  GameReducer.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/31.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import ReSwift

func gameReducer(action: Action, state: GameState?) -> GameState {
    var state = state ?? GameState(memoryCards: [], showLoading: false, gameFinshed: false)
    switch action {
    case _ as FetchTunesAction:
        state = GameState(memoryCards: [], showLoading: true, gameFinshed: false)
    case let setCardsAction as SetCardsAction:
        state.memoryCards = generateNewCards(with: setCardsAction.cardImageUrls)
        state.showLoading = false
    case  let flipCardAction as FilpCardAction:
        state.memoryCards = flipCard(index: flipCardAction.cardIndexToFlip, memoryCards: state.memoryCards)
        state.gameFinshed = hasFinishedGame(cards: state.memoryCards)
    default: break
        
    }
    return state
}
