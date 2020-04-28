//
//  RealmMovie.swift
//  work_6
//
//  Created by Stanislav Belsky on 28.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMovie: Object {
    @objc dynamic var id: Int64
    @objc dynamic var title: String
    @objc dynamic var originalTitle: String
    @objc dynamic var posterPath: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["title"]
    }
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.originalTitle = movie.originalTitle
        self.posterPath = movie.posterPath
    }
    
    init(id: Int64, title: String, originalTitle: String, posterPath: String?) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.posterPath = posterPath
    }
    
    required init() {
        self.id = 0
        self.title = ""
        self.originalTitle = ""
        self.posterPath = nil
    }
}


