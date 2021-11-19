//
//  BatchUpdates.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation
import UIKit

struct BatchUpdates {
    let deleted: [Int]
    let inserted: [Int]
    let moved: [(Int, Int)]
    let reloaded: [Int]
    
    static func compare<T: Equatable>(oldValues: [T], newValues: [T]) ->
    BatchUpdates {
        var deleted = [Int]()
        var moved = [(Int, Int)]()
        var remainingNewValues = newValues
            .enumerated()
            .map { (element: $0.element, offset: $0.offset,
                    alreadyFound: false) }
        outer: for oldValue in oldValues.enumerated() {
            for newValue in remainingNewValues {
                if oldValue.element == newValue.element &&
                    !newValue.alreadyFound {
                    
                    if oldValue.offset != newValue.offset {
                        moved.append((oldValue.offset, newValue.offset))
                    }
                    
                    remainingNewValues[newValue.offset]
                        .alreadyFound = true
                    continue outer
                }
            }
            deleted.append(oldValue.offset)
        }
        let inserted = remainingNewValues
            .filter { !$0.alreadyFound }
            .map { $0.offset }
        return BatchUpdates(deleted: deleted, inserted: inserted,
                            moved: moved, reloaded: [])
    }
}
