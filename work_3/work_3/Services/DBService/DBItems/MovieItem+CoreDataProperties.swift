//
//  MovieItem+CoreDataProperties.swift
//  work_3
//
//  Created by Stanislav Belsky on 27.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieItem> {
        return NSFetchRequest<MovieItem>(entityName: "MovieItem")
    }

    @NSManaged public var originalTitle: String
    @NSManaged public var title: String
    @NSManaged public var posterPath: String?
    @NSManaged public var id: Int64

}
