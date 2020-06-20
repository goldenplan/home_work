//
//  unit_test_w_view_model.swift
//  work_14_unit_tests
//
//  Created by Stanislav Belsky on 6/20/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import XCTest
import Combine
@testable import work_14

class unit_test_weather_view_model: XCTestCase {

    private var cancellableSet: Set<AnyCancellable> = []
    
    let mockWeatherService = MockWeatherService()
    
    let countryData = CountryData(
        id: 1,
        city: "foo",
        name: "bar",
        country: "rf",
        countryCode: "ru",
        latitude: 1.222,
        longitude: 1.333)
    
    let weatherObject = WeatherObject(
        id: 1,
        main: "foo",
        description: "bar",
        icon: "icon")
    let mainObject = MainObject(
        temp: 0.35,
        feels_like: 0.3,
        temp_min: 0.3,
        temp_max: 0.4,
        pressure: 3,
        humidity: 4)
    
    func testInitWithData(){
        
        let viewModel = WeatherViewModel(countryData: countryData, weatherService: mockWeatherService)
        XCTAssertEqual(viewModel.countryData, countryData)
    }
    
    func testDataUpdate(){
        
        mockWeatherService.weatherModel = WeatherModel(weather: [weatherObject], main: mainObject)
        let weatherViewModel = WeatherViewModel(countryData: countryData, weatherService: mockWeatherService)
        
        let weatherExpectation = expectation(description: "Weather expectation")
        
        var weatherValue: String?
        weatherViewModel.$weather.dropFirst().sink { (value) in
            weatherValue = value
            weatherExpectation.fulfill()
        }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 3) { _ in
            XCTAssertEqual(weatherValue, "0.35ºC")
        }
        
    }
    
    func testDataUpdateWithError(){
        
        mockWeatherService.weatherModel = nil
        mockWeatherService.apiError = ApiError.responseError(500)
        let weatherViewModel = WeatherViewModel(countryData: countryData, weatherService: mockWeatherService)
        
        let weatherExpectation = expectation(description: "Weather expectation")
        
        var weatherValue: String?
        weatherViewModel.$weather.dropFirst().sink { (value) in
            weatherValue = value
            weatherExpectation.fulfill()
        }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 3) { _ in
            XCTAssertEqual(weatherValue, "--ºC")
        }
        
    }

}
