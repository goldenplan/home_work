//
//  MovieViewModel.swift
//  work_4
//
//  Created by Stanislav Belsky on 01.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import ApiLibrary

final class MovieViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var showCancelButton: Bool = true
    @Published var movies: [Movie] = []
    
    @Published var searchTerm: String = ""
    
    var locator: MovieServiceLocator!

    var service: MovieApiService{ // You can try replace class - MovieDBService
        return locator.getService()
    }
    
    private var disposeBag = Set<AnyCancellable>()
    
    init(locator: MovieServiceLocator) {
        
        self.locator = locator
        
        $isLoading.dropFirst().sink { (val) in
            print("loading", val)
        }
        .store(in: &disposeBag)
        
        subscribeToChangeValue()
        
    }
    
    func subscribeToChangeValue(){
        
        $searchTerm
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
            
        }) { (value) in
            let state = StateData(lastSearch: value)
            StateService.saveState(state)
        }
        .store(in: &disposeBag)
        
        
        $searchTerm
        .removeDuplicates()
        .debounce(for: 0.5, scheduler: DispatchQueue.main)
        .setFailureType(to: Error.self)
        .flatMap({ [unowned self] (search)  -> AnyPublisher<[Movie], Error> in
            DispatchQueue.main.async {
                self.isLoading = true
            }
            return self.service.fetchMovies(search: search)
        })
        .handleEvents(
            receiveOutput: { [unowned self] _ in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
        })
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [unowned self] (completion) in
            
           switch completion {
           case .failure(let error):
               print("Service error: ", error)
               self.tryLoadFromFileCache(search: self.searchTerm)
           case .finished:
               print("DONE - fetchMovies")
           }
        }, receiveValue: { [unowned self] (results) in
            
            self.movies = results
            
            let cache: MovieDBService? = self.locator.tryGetService()
            cache?.saveMovies(results)
            
        })
        .store(in: &disposeBag)
        
    }
    
    func tryLoadFromFileCache(search: String){
        
        service.cacheManager?.getResults(filter: search, type: MovieData.self).sink(receiveCompletion: { (completion) in
            
            switch completion {
            case .failure(let error):
                print("Cache error: ", error)
            case .finished:
                print("DONE - fetchMovies from file cache")
            }
            
        }, receiveValue: { (results) in
            self.movies = results
        })
        .store(in: &disposeBag)
        
    }
    
    deinit {
        for cancell in disposeBag{
            cancell.cancel()
        }
    }
    
}

