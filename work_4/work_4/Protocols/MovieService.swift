//
//  MovieService.swift
//  work_4
//
//  Created by Stanislav Belsky on 01.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine
import ApiLibrary

protocol MovieService {
    func fetchMovies<T>(search: String) -> AnyPublisher<[T], Error>
}

extension MovieApiService: MovieService{}

