//
//  CardCollectionViewCell.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/11/1.
//  Copyright © 2018 chen liang. All rights reserved.
//

import UIKit
import Kingfisher

final class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!
    func configureCell(with cardState: MemoryCard) {
        let url = URL(string: cardState.imageUrl)
        cardImageView.kf.setImage(with: url)
        cardImageView.alpha = cardState.isAlreadyGussed || cardState.isFilpped ? 1 : 0
    }
}
