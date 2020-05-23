//
//  Array.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

extension Array where Element == SuffixTuple{
    
    func showTuples() {
        self.forEach { (item) in
            print("Name: ", item.algoName)
            item.suffix.forEach { (inner) in
                print("-", inner)
            }
        }
    }
    
}
