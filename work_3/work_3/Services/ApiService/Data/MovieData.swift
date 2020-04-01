//
//  MovieData.swift
//  work_3
//
//  Created by Stanislav Belsky on 26.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct MovieData: Codable, Movie {

    var id: Int64
    var mediaType: MediaType?
    var originalTitle: String
    var title: String
    var posterPath: String?
    
}
