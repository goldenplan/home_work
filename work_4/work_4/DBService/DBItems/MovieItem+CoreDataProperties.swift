//
//  MovieItem+CoreDataProperties.swift
//  work_4
//
//  Created by Stanislav Belsky on 01.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieItem> {
        return NSFetchRequest<MovieItem>(entityName: "MovieItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var originalTitle: String
    @NSManaged public var posterPath: String?
    @NSManaged public var title: String

}
