//
//  unit_test_country_view_model.swift
//  work_14_unit_tests
//
//  Created by Stanislav Belsky on 6/20/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import XCTest
import Combine
@testable import work_14

class unit_test_country_view_model: XCTestCase {

    private var cancellableSet: Set<AnyCancellable> = []
    
    let mockCountryService = MockCountryService()
    
    let langData = LangData(code: "es", name: "Spanish")
    
    let countryData = CountryData(id: 1, city: "foo", name: "bar", country: "rf", countryCode: "ff", latitude: 1.222, longitude: 1.333)
    
    func testLangUpdate(){
        
        mockCountryService.langDataArray = [langData]
        
        let countryViewModel = CountryViewModel(countryService: mockCountryService)
        
        let langExpectation = expectation(description: "Lang expectation")
        
        countryViewModel.$languages.dropFirst().sink { (array) in
            langExpectation.fulfill()
        }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 3) { _ in
            XCTAssertEqual(countryViewModel.languages.count, 1)
            XCTAssertEqual(countryViewModel.languages.first, self.langData)
        }
    }
    
    func testCountryList(){
        
        mockCountryService.langDataArray = [langData]
        mockCountryService.coutryDataArray = [countryData]
        
        let countryViewModel = CountryViewModel(countryService: mockCountryService)
        
        let countryExpectation = expectation(description: "County expectation")
        
        
        countryViewModel.$countries.dropFirst().sink { (array) in
            countryExpectation.fulfill()
        }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 3) { _ in
            XCTAssertEqual(countryViewModel.countries.count, 1)
            XCTAssertEqual(countryViewModel.countries.first, self.countryData)
        }
    }

}
