//
//  unit_test_weather_route.swift
//  work_14_unit_tests
//
//  Created by Stanislav Belsky on 6/19/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import XCTest
@testable import work_14

class unit_test_weather_route: XCTestCase {

    func testWeatherRoute(){
        
        let weatherRoute = WeatherRoute.getWeather(longitude: 1.11, latitude: 2.22)
        
        XCTAssertEqual(weatherRoute.header, [:])
        XCTAssertEqual(weatherRoute.method, HTTPMethod.get)
        XCTAssertEqual(weatherRoute.path, "\(WeatherRoute.apiUrl)weather?lat=2.22&lon=1.11&units=metric&appid=\(WeatherRoute.apiKey)")
    }

}
