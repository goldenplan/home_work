//
//  MovieItem+CoreDataClass.swift
//  work_4
//
//  Created by Stanislav Belsky on 01.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MovieItem)
public class MovieItem: NSManagedObject {

    @discardableResult
    static func createOrUpdate(
        movieData: Movie,
        in context: NSManagedObjectContext) -> MovieItem?{
        
        var movieItem = MovieItem.find(id: Int64(movieData.id), in: context)
        
        if movieItem == nil{
            
            movieItem = MovieItem(context: context)
            
        }
        
        movieItem!.id = Int64(movieData.id)
        movieItem!.title = movieData.title
        movieItem!.originalTitle = movieData.originalTitle
        movieItem!.posterPath = movieData.posterPath
        
        context.trySave()
        
        return movieItem
    }
    
    static func find(
        id: Int64,
        in context: NSManagedObjectContext) -> MovieItem?{
        
        let fetchRequest: NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
        
        let idPredicate = NSPredicate(format: "id == \(id)")
        
        fetchRequest.predicate = idPredicate
        
        if let movieItems = try? context.fetch(fetchRequest) {
            if let movieItem = movieItems.first{
                return movieItem
            }else{
                return nil
            }
        } else {
            print("There was an error getting the results")
            return nil
        }
        
    }
    
    static func find(
        search: String,
        in context: NSManagedObjectContext) -> [MovieItem]{
        
        let fetchRequest: NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
        
        if !search.isEmpty{
            
            let searchTitlePredicate = NSPredicate(format: "title contains %@", search)
            let searchOriginalPredicate = NSPredicate(format: "originalTitle contains %@", search)
            let orPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [searchTitlePredicate, searchOriginalPredicate])
        
        
            fetchRequest.predicate = orPredicate
        }
        
        
        if let movieItems = try? context.fetch(fetchRequest) {
            return movieItems
        } else {
            print("There was an error getting the results")
            return []
        }
        
    }
}
