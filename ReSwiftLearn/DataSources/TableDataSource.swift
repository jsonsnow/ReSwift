//
//  TableDataSource.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import UIKit

final class TableDataSource<V, T>:NSObject,UITableViewDataSource where V:UITableViewCell {
    
    typealias CellConfiguration = (V,T) -> V
    private let models:[T]
    private let configCell:CellConfiguration
    private let cellIdentifier:String
    
    init(cellIdentifier:String, models:[T], configureCell:@escaping CellConfiguration) {
        self.models = models
        self.cellIdentifier = cellIdentifier
        self.configCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? V
        guard let currentCell = cell else {
            fatalError("Identifier or class not registerd with this table view")
        }
        let model = models[indexPath.row]
        return configCell(currentCell,model)
    }
    
    
}
