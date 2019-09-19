//
//  Future_HopeUITests.swift
//  Future-HopeUITests
//
//  Created by HSV on 9/19/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import XCTest

class Future_HopeUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    
    func testEmailSignUp() {
        
        let app = XCUIApplication()
        app.buttons["Email SignUp"].tap()
        app.scrollViews.otherElements.textFields["Name *"].tap()
        
    }
    
    override func tearDown() {
    }

    func testExample() {
    }

}
