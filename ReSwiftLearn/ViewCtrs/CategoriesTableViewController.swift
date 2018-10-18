//
//  CategoriesTableViewController.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/18.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import UIKit
import ReSwift

class CategoriesTableViewController: UITableViewController {

    var tableDataSource:TableDataSource<UITableViewCell,Category>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) {
            $0.select {
                $0.categoriesState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        store.dispatch(ChangeCategoryAction(categoryIndex:indexPath.row))
    }
    
}

extension CategoriesTableViewController :StoreSubscriber {
    
    func newState(state: CategoriesState) {
        tableDataSource = TableDataSource(cellIdentifier: "CategoryCell", models: state.categories, configureCell: { (cell, model) -> UITableViewCell in
            cell.textLabel?.text = model.rawValue
            cell.accessoryType = (state.currentCategorySelected == model) ? .checkmark: .none
            return cell
        })
        self.tableView.dataSource = tableDataSource
        self.tableView.reloadData()
    }
}
