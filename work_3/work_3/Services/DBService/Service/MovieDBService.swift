//
//  MovieDBService.swift
//  work_3
//
//  Created by Stanislav Belsky on 27.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

class MovieDBService: MovieService {
    
    private var mainContext = CoreDataStack.sharedInstance.mainContext
    
    func saveMovies(_ movies: [Movie]){
        
        movies.forEach { (item) in
            
            MovieItem.createOrUpdate(movieData: item, in: mainContext)
        }
        
        print("DONE - saveMovies")
    }
    
    func fetchMovies(search: String) -> AnyPublisher<[Movie], AppError> {

        return Future<[Movie], AppError>(){ promise in
            
            let movies = MovieItem.find(search: search, in: self.mainContext)
            promise(.success(movies))
            
        }
        .eraseToAnyPublisher()
    }
    
}
