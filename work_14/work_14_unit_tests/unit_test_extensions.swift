//
//  unit_test_extensions.swift
//  work_14_unit_tests
//
//  Created by Stanislav Belsky on 6/19/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import XCTest
@testable import work_14

class unit_test_extensions: XCTestCase {

    func testRandomAccessCollectionIsLast(){
        
        let country1 = CountryData(id: 1, city: "foo1", name: "bar1", country: "lola1", countryCode: "ll1", latitude: 1.222, longitude: 1.333)
        let country2 = CountryData(id: 2, city: "foo2", name: "bar2", country: "lola2", countryCode: "ll2", latitude: 1.222, longitude: 1.333)
        
        let array = [country1, country2]
        XCTAssertTrue(array.isLast(country2))
        
    }
    
}
