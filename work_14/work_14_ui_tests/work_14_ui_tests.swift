//
//  work_14_ui_tests.swift
//  work_14_ui_tests
//
//  Created by Stanislav Belsky on 6/19/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import XCTest

class work_14_ui_tests: XCTestCase {

    func testUINavigarion() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app/*@START_MENU_TOKEN@*/.buttons["English"]/*[[".segmentedControls.buttons[\"English\"]",".buttons[\"English\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Spanish"]/*[[".segmentedControls.buttons[\"Spanish\"]",".buttons[\"Spanish\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["French"]/*[[".segmentedControls.buttons[\"French\"]",".buttons[\"French\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Italian"]/*[[".segmentedControls.buttons[\"Italian\"]",".buttons[\"Italian\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Latitude: 24.478056"]/*[[".cells.staticTexts[\"Latitude: 24.478056\"]",".staticTexts[\"Latitude: 24.478056\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["arrow.left"].tap()
        
        
    }
}
