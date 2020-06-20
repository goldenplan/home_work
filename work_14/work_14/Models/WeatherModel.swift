//
//  WeatherModel.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    let weather     : [WeatherObject]
    let main        : MainObject
}

struct WeatherObject: Decodable, Equatable {
    var id          : Int
    var main        : String
    var description : String
    var icon        : String
}

struct MainObject: Decodable, Equatable {
    var temp        : Double
    var feels_like  : Double
    var temp_min    : Double
    var temp_max    : Double
    var pressure    : Int
    var humidity    : Int
}
