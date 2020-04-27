//
//  MovieApi.swift
//  work_3
//
//  Created by Stanislav Belsky on 26.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

public class MovieApiService: ApiService {
    
    public var cacheManager: CacheManager?
    
    public init(cacheManager: CacheManager?) {
        super.init()
        self.cacheManager = cacheManager
    }
    
    public func fetchMovies<T>(search: String) -> AnyPublisher<[T], Error> {

        let route = search.isEmpty
            ? MovieRoute.discover(mediaType: .Movie, page: 1)
            : MovieRoute.search(type: .Movie, query: search, page: 1)

        return fetch(route, type: MovieSearchData.self)
            .compactMap{
                
                self.cacheManager?.storeResult(result: $0.results)

                return $0.results as? [T]
                
            }
            .eraseToAnyPublisher()

    }
    
    public func fetchMoviesFromFileCache<T>(search: String) -> AnyPublisher<[T], Error> {
        
        return cacheManager!.getResults(filter: search, type: MovieData.self)
            .compactMap{

                return $0 as? [T]
                
            }
            .eraseToAnyPublisher()

    }
    
}
