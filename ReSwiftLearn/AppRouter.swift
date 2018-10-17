//
//  AppRouter.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/17.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

enum RoutingDestination:String {
    case menu = "MenuTableViewController"
    case categories = "CategoriesTableViewController"
    case game = "GameViewController"
}

final class AppRouter {
    let navigationController: UINavigationController
    init(window:UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
    }
    
    fileprivate func pushViewController(identifier: String, animated:Bool) {
        let viewController = instantiateViewController(identifier: identifier)
        let newViewCtrType = type(of: viewController)
        if let cuCtr = navigationController.topViewController {
            let cuCtrType = type(of: cuCtr)
            if cuCtrType == newViewCtrType {
                return
            }
        }
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    private func instantiateViewController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier:identifier)
    }
}

extension AppRouter:StoreSubscriber {
    
    func newState(state: RoutingState) {
        let shouldAnimate = navigationController.topViewController != nil
        pushViewController(identifier: state.navigationState.rawValue, animated: shouldAnimate)
    }
}
