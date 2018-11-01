//
//  MemoryGameLogic.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/11/1.
//  Copyright © 2018 chen liang. All rights reserved.
//

import Foundation
import GameplayKit

private struct MemoryGameConstants {
    static let numberOfUniqueCards = 8
}

private typealias C = MemoryGameConstants

func generateNewCards(with cardImageUrls:[String]) -> [MemoryCard] {
    var memoryCards = cardImageUrls[0..<C.numberOfUniqueCards].map {
        MemoryCard(imageUrl: $0, isFilpped: false, isAlreadyGussed: false)
    }
    memoryCards.append(contentsOf: memoryCards)
    return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: memoryCards) as! [MemoryCard]
    
}

func flipCard(index: Int, memoryCards: [MemoryCard]) -> [MemoryCard] {
    var changedCards = memoryCards
    
    changedCards[index].isFilpped = true
    let alreadyFlippedCardsInGame = changedCards.filter({ card -> Bool in
        return !card.isAlreadyGussed && card.isFilpped
    })
    
    if alreadyFlippedCardsInGame.count == 2 {
        let firstCardUrl = alreadyFlippedCardsInGame[0].imageUrl
        let secondCardUrl = alreadyFlippedCardsInGame[1].imageUrl
        
        let playerGuessedRight = firstCardUrl == secondCardUrl
        
        if playerGuessedRight {
            changedCards = checkGuessedCards(for: firstCardUrl, in: changedCards)
        }
    }
    
    if alreadyFlippedCardsInGame.count == 3 {
        changedCards = flipBackCards(changedCards, exceptIndex: index)
    }
    
    return changedCards
}

func checkGuessedCards(for imageUrl: String,in cards:[MemoryCard]) -> [MemoryCard] {
    var changeCards = cards
    for index in 0 ..< cards.count {
        if cards[index].imageUrl == imageUrl {
            changeCards[index].isAlreadyGussed = true
        }
    }
    return changeCards
}

func flipBackCards(_ cards: [MemoryCard], exceptIndex: Int) -> [MemoryCard] {
    var chagedCards = cards
    for index in 0 ..< cards.count {
        if index != exceptIndex {
            chagedCards[index].isFilpped = false
        }
    }
    return chagedCards
}

func hasFinishedGame(cards: [MemoryCard]) -> Bool {
    for card in cards {
        if !card.isAlreadyGussed {
            return false
        }
    }
    return true
}
