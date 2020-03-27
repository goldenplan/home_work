//
//  Service.swift
//  work_3
//
//  Created by Stanislav Belsky on 27.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

protocol MovieService {
    func fetchMovies(search: String) -> AnyPublisher<[Movie], AppError>
}
