//
//  SuffixSequence.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct SuffixSequence: Sequence{
    let string: String
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string: string)
    }
}
