//
//  Movie.swift
//  work_4
//
//  Created by Stanislav Belsky on 01.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import ApiLibrary

protocol Movie {
    var id              : Int64 { get }
    var title           : String { get }
    var originalTitle   : String { get }
    var posterPath      : String? { get }
}


extension MovieData: Movie{}


extension RealmMovie: Movie{}
