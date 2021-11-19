//
//  UICollectionView+Additions.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation
import UIKit

extension UICollectionView {
    func reloadData(with batchUpdates: BatchUpdates, forSection section: Int = 0) {
        performBatchUpdates({ [weak self] in
            self?.insertItems(at: batchUpdates.inserted.map {
                IndexPath(row: $0, section: section) })
            self?.deleteItems(at: batchUpdates.deleted.map {
                IndexPath(row: $0, section: section) })
            self?.reloadItems(at: batchUpdates.reloaded.map {
                IndexPath(row: $0, section: section) })
            for movedRows in batchUpdates.moved {
                self?.moveItem(
                    at: IndexPath(row: movedRows.0, section: section),
                    to: IndexPath(row: movedRows.1, section: section)
                )
            }
        })
    }
}
