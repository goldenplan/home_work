//
//  MovieResponce.swift
//  work_3
//
//  Created by Stanislav Belsky on 26.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct MovieSearchData: Codable {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [MovieData]
    
}
