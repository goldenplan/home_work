//
//  SuffixWorker.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct SuffixWorker {
    
    static func find(limit: Int, frases: [String], tups: [SuffixTuple]) -> Int{
        
        var resultCount = 0
        
        for frase in frases{
            for item in tups{
                for suffix in item.suffix{
                    if suffix.string.contains(frase){
                        resultCount += 1
                    }
                    if resultCount == limit && resultCount != 0 { return resultCount }
                }
            }
        }
        
        return resultCount
    }
    
    @discardableResult
    static func parseAllWords(of array: [String]) -> [SuffixSequence]{
        array
            .reduce([], {$0 + $1.split(separator: " ")
                .map({SuffixSequence(string: String($0))})})
    }
    
    @discardableResult
    static func makeTuples(of array: [String]) -> [SuffixTuple]{
        array
            .map { (suffix: $0.split(separator: " ")
                .map{SuffixSequence(string: String($0))}, algoName: $0)}
            .sorted(by: {$0.algoName < $1.algoName})
    }
    
}


