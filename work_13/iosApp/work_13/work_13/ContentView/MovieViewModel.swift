//
//  MovieViewModel.swift
//  work_13
//
//  Created by Stanislav Belsky on 6/14/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import shared

final class MovieViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var showCancelButton: Bool = true
    @Published var movies: [Movie] = []
    
    @Published var searchTerm: String = ""
    
    var locator: MovieServiceLocator!
    
    var service: MoviePresentation{
        return locator.getService()
    }
    
    private var disposeBag = Set<AnyCancellable>()
    
    init(locator: MovieServiceLocator) {
        
        self.locator = locator
        
        $isLoading.dropFirst().sink { (val) in
            print("loading", val)
        }
        .store(in: &disposeBag)
        
        
        $searchTerm
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (item) in
                
                guard let strongSelf = self else { return }
                
                if item.isEmpty{
                    strongSelf.service.fetchMoviesWithoutTimeout { (movies) in
                        strongSelf.movies = movies
                    }
                }else{
                    strongSelf.service.searchMoviesWithoutTimeout(frase: item){ (movies) in
                        strongSelf.movies = movies
                    }
                }
                    
            })
            .store(in: &disposeBag)
        
    }
    
    deinit {
        disposeBag.forEach { (item) in
            item.cancel()
        }
    }
    
}
