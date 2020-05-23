//
//  SearchViewModel.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var showCancelButton: Bool = true
    @Published var movies: [String] = []
    
    @Published var searchTerm: String = ""
    
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        
        $isLoading.dropFirst().sink { (val) in
            print("loading", val)
        }
        .store(in: &disposeBag)
        
        $searchTerm
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { (item) in
                print("item", item)
            })
            .store(in: &disposeBag)
        
    }
    
    deinit {
        for cancell in disposeBag{
            cancell.cancel()
        }
    }
    
}

