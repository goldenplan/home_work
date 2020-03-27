//
//  Movie.swift
//  work_3
//
//  Created by Stanislav Belsky on 27.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

protocol Movie {
    var id              : Int64 { get set }
    var title           : String { get set }
    var originalTitle   : String { get set }
    var posterPath      : String? { get set }
}
