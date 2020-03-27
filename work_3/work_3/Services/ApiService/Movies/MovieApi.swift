//
//  MovieApi.swift
//  work_3
//
//  Created by Stanislav Belsky on 26.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

class MovieApiService: ApiService, MovieService {
    
    func fetchMovies(search: String) -> AnyPublisher<[Movie], AppError> {

        let route = search.isEmpty
            ? MovieRoute.discover(mediaType: .Movie, page: 1)
            : MovieRoute.search(type: .Movie, query: search, page: 1)

        return fetch(route, type: MovieSearchData.self)
            .map{$0.results}
            .eraseToAnyPublisher()

    }
    
}
