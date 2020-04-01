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
    
    public override init() {}
    
    public func fetchMovies<T>(search: String) -> AnyPublisher<[T], Error> {

        let route = search.isEmpty
            ? MovieRoute.discover(mediaType: .Movie, page: 1)
            : MovieRoute.search(type: .Movie, query: search, page: 1)

        return fetch(route, type: MovieSearchData.self)
            .compactMap{$0.results as? [T]}
            .eraseToAnyPublisher()

    }
    
}
