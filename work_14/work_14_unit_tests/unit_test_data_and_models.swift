//
//  work_14_unit_tests.swift
//  work_14_unit_tests
//
//  Created by Stanislav Belsky on 6/19/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import XCTest
@testable import work_14

class work_14_unit_tests: XCTestCase {

    func testInitLangData() -> LangData{
        let langData = LangData(code: "es", name: "Spanish")
        XCTAssertEqual(langData.code, "es")
        XCTAssertEqual(langData.name, "Spanish")
        return langData
    }

    func testInitLangModel(){
        let langData = testInitLangData()
        let langModel = LangModel(data: [langData])
        XCTAssertEqual(langModel.data.count, 1)
    }
    
    func testInitMainObject(){
        let mainObject = MainObject(
            temp: 0.35,
            feels_like: 0.3,
            temp_min: 0.3,
            temp_max: 0.4,
            pressure: 3,
            humidity: 4)
        XCTAssertEqual(mainObject.temp, 0.35)
        XCTAssertEqual(mainObject.feels_like, 0.3)
        XCTAssertEqual(mainObject.temp_min, 0.3)
        XCTAssertEqual(mainObject.temp_max, 0.4)
        XCTAssertEqual(mainObject.pressure, 3)
        XCTAssertEqual(mainObject.humidity, 4)
    }
    
    func testInitWeatherObject(){
        let weatherObject = WeatherObject(id: 1, main: "foo", description: "bar", icon: "icon")
        XCTAssertEqual(weatherObject.id, 1)
        XCTAssertEqual(weatherObject.main, "foo")
        XCTAssertEqual(weatherObject.description, "bar")
        XCTAssertEqual(weatherObject.icon, "icon")
    }
    
    func testInitWeatherModel(){
        let mainObject = MainObject(
            temp: 0.35,
            feels_like: 0.3,
            temp_min: 0.3,
            temp_max: 0.4,
            pressure: 3,
            humidity: 4)
        let weatherObject = WeatherObject(id: 1, main: "foo", description: "bar", icon: "icon")
        let weatherModel = WeatherModel(weather: [weatherObject], main: mainObject)
        XCTAssertNotNil(weatherModel.weather.first)
        XCTAssertEqual(weatherModel.weather.first, weatherObject)
        XCTAssertEqual(weatherModel.main, mainObject)
    }
    
    func testInitMainObjectFromJson(){
        let data = """
            {
                "temp": 0.35,
                "feels_like": 0.3,
                "temp_min": 0.3,
                "temp_max": 0.4,
                "pressure": 3,
                "humidity": 4,
            }
            """.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        let mainObject = try? jsonDecoder.decode(MainObject.self, from: data)
        XCTAssertNotNil(mainObject)
        XCTAssertEqual(mainObject!.temp, 0.35)
        XCTAssertEqual(mainObject!.feels_like, 0.3)
        XCTAssertEqual(mainObject!.temp_min, 0.3)
        XCTAssertEqual(mainObject!.temp_max, 0.4)
        XCTAssertEqual(mainObject!.pressure, 3)
        XCTAssertEqual(mainObject!.humidity, 4)
    }
    
    func testInitWeatherObjectFromJson(){
        let data = """
            {
                "id": 1,
                "main": "foo",
                "description": "bar",
                "icon": "icon"
            }
            """.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        let weatherObject = try? jsonDecoder.decode(WeatherObject.self, from: data)
        XCTAssertNotNil(weatherObject)
        XCTAssertEqual(weatherObject!.id, 1)
        XCTAssertEqual(weatherObject!.main, "foo")
        XCTAssertEqual(weatherObject!.description, "bar")
        XCTAssertEqual(weatherObject!.icon, "icon")
    }
    
    func testInitWeatherModelFromJson(){
        let data = """
            {
                "weather": [
                    {
                        "id": 1,
                        "main": "foo",
                        "description": "bar",
                        "icon": "icon"
                    }
                ],
                "main":{
                    "temp": 0.35,
                    "feels_like": 0.3,
                    "temp_min": 0.3,
                    "temp_max": 0.4,
                    "pressure": 3,
                    "humidity": 4,
                }
            }
            
            """.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        let weatherModel = try? jsonDecoder.decode(WeatherModel.self, from: data)
        XCTAssertNotNil(weatherModel)
    }

    func testInitLangDataFromJson(){
        let data = """
            {
                "code": "de",
                "name": "German"
            }
            
            """.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        let langData = try? jsonDecoder.decode(LangData.self, from: data)
        XCTAssertNotNil(langData)
        XCTAssertEqual(langData!.code, "de")
        XCTAssertEqual(langData!.name, "German")
    }
    
    func testInitCountryDataFromJson(){
        let data = """
            {
                "id": 1,
                "city": "Moscow",
                "name": "Russia",
                "country": "RF",
                "countryCode": "ru",
                "latitude": 1.333,
                "longitude": 1.222
            }
            
            """.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        let countryData = try? jsonDecoder.decode(CountryData.self, from: data)
        XCTAssertNotNil(countryData)
        XCTAssertEqual(countryData!.id, 1)
        XCTAssertEqual(countryData!.city, "Moscow")
        XCTAssertEqual(countryData!.name, "Russia")
        XCTAssertEqual(countryData!.country, "RF")
        XCTAssertEqual(countryData!.countryCode, "ru")
        XCTAssertEqual(countryData!.latitude, 1.333)
        XCTAssertEqual(countryData!.longitude, 1.222)
    }
    
    func testInitCountryModelFromJson(){
        let data = """
            {
                "data": [
                    {
                        "id": 1,
                        "city": "Moscow",
                        "name": "Russia",
                        "country": "RF",
                        "countryCode": "ru",
                        "latitude": 1.333,
                        "longitude": 1.222
                    }
                ]
            }
            
            """.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        let countryModel = try? jsonDecoder.decode(CountryModel.self, from: data)
        XCTAssertNotNil(countryModel)
        XCTAssertNotNil(countryModel!.data.first)
    }
    
    func testRandomAccessCollectionIsLast(){
        
        let country1 = CountryData(id: 1, city: "foo1", name: "bar1", country: "lola1", countryCode: "ll1", latitude: 1.222, longitude: 1.333)
        let country2 = CountryData(id: 2, city: "foo2", name: "bar2", country: "lola2", countryCode: "ll2", latitude: 1.222, longitude: 1.333)
        
        let array = [country1, country2]
        XCTAssertTrue(array.isLast(country2))
        
    }
    
}
