//
//  TestViewModel.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class TestViewModel: ObservableObject {
    
    @Published var creationAllWordsTime: TimeInterval? = 0
    @Published var creationTublesTime: TimeInterval? = 0
    
    @Published var searchingTime: TimeInterval? = 0
    @Published var findCount: Int = 0
    
    @Published var sliderValue = 0.0
    var minimumValue = 0.0
    var maximumvalue = 100.0
    
    var tups: [SuffixTuple] = []
    
    func runTest(){
        
        creationAllWordsTime = nil
        creationTublesTime = nil
        searchingTime = nil
        findCount = 0
        tups = []
        
        
        DispatchQueue.init(label: "tests", qos: .userInitiated).async {
            
            [weak self] in
            
            guard let strongSelf = self else { return }
            
            let creationAllWordsTime = Profiler.runClosureForTime {
                SuffixWorker.parseAllWords(of: AlgoProvider().all)
            }
            
            let creationTublesTime = Profiler.runClosureForTime {
                strongSelf.tups = SuffixWorker.makeTuples(of: AlgoProvider().all)
                strongSelf.tups.showTuples()
            }
            
            var findCount = 0
            let frases: [String] = (1...10).map { (_) -> String in
                StringGenerator().generateRandomString(3)
            }
            
            print(frases)
            
            let searchingTime = Profiler.runClosureForTime {
                findCount = SuffixWorker.find(limit: Int(strongSelf.sliderValue), frases: frases, tups: strongSelf.tups)
            }
            
            DispatchQueue.main.async {
                
                strongSelf.creationAllWordsTime = creationAllWordsTime
                strongSelf.creationTublesTime = creationTublesTime
                strongSelf.searchingTime = searchingTime
                strongSelf.findCount = findCount
                
            }
            
        }
        
    }
    
    deinit {
        
    }
    
}

