//
//  SuffixIterator.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct SuffixIterator: IteratorProtocol{
    let string: String
    var offset: String.Index
    init(string: String) {
        self.string = string
        offset = string.endIndex
    }
    
    mutating func next() -> Substring? {
        guard offset > string.startIndex else { return nil }
        offset = string.index(before: offset)
        return string[offset..<string.endIndex]
    }
}
