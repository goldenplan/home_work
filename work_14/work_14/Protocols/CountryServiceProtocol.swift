//
//  CountryServiceProtocol.swift
//  work_14
//
//  Created by Stanislav Belsky on 6/20/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import Combine

protocol CountryServiceProtocol {
    func getLanguages() -> Future<[LangData], ApiError>
    func getCities(lang: String, page: Int) -> Future<[CountryData], ApiError>
}
