//
//  MovieData.swift
//  work_3
//
//  Created by Stanislav Belsky on 26.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

public struct MovieData: Codable {

    public var id: Int64
    var mediaType: MediaType?
    public var originalTitle: String
    public var title: String
    public var posterPath: String?
    
}
