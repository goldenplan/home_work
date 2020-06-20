//
//  unit_test_country_route.swift
//  work_14_unit_tests
//
//  Created by Stanislav Belsky on 6/19/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import XCTest
@testable import work_14

class unit_test_country_route: XCTestCase {

    func testCountryRouteGetCities(){
        
        let countryRoute = CountryRoute.getCities(lang: "ru", page: 1)
        
        XCTAssertEqual(countryRoute.header, [:])
        XCTAssertEqual(countryRoute.method, HTTPMethod.get)
        XCTAssertEqual(countryRoute.path, "\(CountryRoute.apiUrl)geo/cities?limit=10&offset=10&languageCode=ru")
    }
    
    func testCountryRouteGetLang(){
        
        let countryRoute = CountryRoute.getLang
        
        XCTAssertEqual(countryRoute.header, [:])
        XCTAssertEqual(countryRoute.method, HTTPMethod.get)
        XCTAssertEqual(countryRoute.path, "\(CountryRoute.apiUrl)locale/languages")
    }

}
