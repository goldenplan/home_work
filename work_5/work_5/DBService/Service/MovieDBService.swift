//
//  MovieDBService.swift
//  work_4
//
//  Created by Stanislav Belsky on 01.04.2020.
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
    
    func fetchMovies<T>(search: String) -> AnyPublisher<[T], Error>  {
        return Future<[MovieItem], Error>(){ promise in
            
            let movies = MovieItem.find(search: search, in: self.mainContext)
            promise(.success(movies))
            
        }
        .compactMap{$0 as? [T]}
        .eraseToAnyPublisher()
    }
    
}

