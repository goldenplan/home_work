//
//  CountryModel.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct CountryModel: Decodable {
    let data: [CountryData]
}

struct CountryData: Decodable, Identifiable, Equatable, Hashable {
    let id          : Int
    let city        : String
    let name        : String
    let country     : String
    let countryCode : String
    let latitude    : Double
    let longitude   : Double
}
