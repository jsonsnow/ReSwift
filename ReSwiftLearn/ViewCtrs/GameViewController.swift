//
//  GameViewController.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/31.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import UIKit
import ReSwift

class GameViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var collectionDataSource: CollectionDataSource<CardCollectionViewCell,MemoryCard>?
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.dispatch(fetchTunes)
        collectionView.delegate = self
        loadingIndicator.hidesWhenStopped = true
        collectionDataSource = CollectionDataSource(cellIdentifier: "CardCell", models: []) { cell, modle in
            cell.configureCell(with: modle)
            return cell
        }
        collectionView.dataSource = collectionDataSource
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        store.subscribe(self) {
            $0.select {
                $0.gameState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func showGameFinshedAlert() {
        let alertController = UIAlertController.init(title: "Congratulations !", message: "You've finished the game!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        store.dispatch(FilpCardAction(cardIndexToFlip: indexPath.row))
    }
}

extension GameViewController: StoreSubscriber {
    func newState(state: GameState)  {
        collectionDataSource?.models = state.memoryCards
        collectionView.reloadData()
        state.showLoading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        if state.gameFinshed {
            showGameFinshedAlert()
            store.dispatch(fetchTunes)
        }
    }
}
