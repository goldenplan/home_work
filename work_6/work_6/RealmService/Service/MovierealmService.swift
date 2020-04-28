//
//  MovierealmService.swift
//  work_6
//
//  Created by Stanislav Belsky on 28.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

class MovieRealmService: MovieService {
    
    func fetchMovies<T>(search: String) -> AnyPublisher<[T], Error>  {
        return Future<[Movie], Error>(){ [weak self] promise in
            
            guard let strongSelf = self else { return }
            
            let movies = strongSelf.getMovies(search: search)
            promise(.success(movies))
            
        }
        .compactMap{$0 as? [T]}
        .eraseToAnyPublisher()
    }
    
    func saveMovies(_ movies: [Movie]){
        
        guard let realm = RealmStack.instance.realm else {
            print("Error connect to realm")
            return
        }
        
        do {
            try realm.write {
                let objs = movies.map{RealmMovie(movie: $0)}
                realm.add(objs, update: .modified)
            }
        } catch let e {
            print("Error saving to realm: \(e)")
        }
        
    }
    
    
    func getMovies(search: String = "") -> [Movie]{
        
        guard let realm = RealmStack.instance.realm else {
            print("Error read from realm")
            return []
        }
        
        if search.isEmpty{
            let objs = realm.objects(RealmMovie.self)
            return objs.sorted{$0.title < $1.title}
        }else{
            let objs = realm.objects(RealmMovie.self).filter("title contains '\(search)'")
            return objs.sorted{$0.title < $1.title}
        }
        
    }
    
}
