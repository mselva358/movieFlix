//
//  Dictionary+Additions.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation

func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}
