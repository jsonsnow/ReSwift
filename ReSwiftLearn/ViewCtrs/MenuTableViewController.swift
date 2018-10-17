//
//  MenuTableViewController.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import UIKit
import ReSwift

class MenuTableViewController: UITableViewController {

    var tableDataSource:TableDataSource<UITableViewCell, String>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) {
            $0.select {
                $0.menuState
            }
        }
        let action = RoutingAction.init(destination: .menu)
        store.dispatch(action)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var routeDestination:RoutingDestination = .categories
        switch indexPath.row {
        case 0:
            routeDestination = .game
        case 1:
            routeDestination = .categories
        default:
            break
        }
        store.dispatch(RoutingAction(destination:routeDestination))
    }
}


extension MenuTableViewController: StoreSubscriber {
    func newState(state: MenuState) {
        tableDataSource = TableDataSource(cellIdentifier: "TitleCell", models: state.menuTitles, configureCell: { (cell, model) -> UITableViewCell in
            cell.textLabel?.text = model
            cell.textLabel?.textAlignment = .center
            return cell
        })
        tableView.dataSource = tableDataSource
        tableView.reloadData()
    }
}
