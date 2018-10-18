//
//  CollectionDataSource.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/18.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import UIKit

final class CollectionDataSource<V,T>:NSObject,UICollectionViewDataSource  where V:UICollectionViewCell {

    typealias CellConfiguration = (V, T) -> V
    var models:[T]
    private let configureCell:CellConfiguration
    private let cellIdentifier:String
    
    init(cellIdentifier:String, models:[T], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? V
        guard let _cell = cell else {
            fatalError("Identifier or class not registerd with this collection view")
        }
        let model = models[indexPath.row]
        return configureCell(_cell, model)
    }
    
}
