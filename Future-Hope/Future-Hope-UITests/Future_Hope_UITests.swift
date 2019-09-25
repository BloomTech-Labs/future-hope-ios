//
//  Future_Hope_UITests.swift
//  Future-Hope-UITests
//
//  Created by HSV on 9/24/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import XCTest

class Future_Hope_UITests: XCTestCase {

    
    
    var app: XCUIApplication {
        return XCUIApplication()
    }
    var profileButton: XCUIElement {
        return app.tabBars.buttons["Profile"]
    }
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    func testGoogleSignIN() {
        
    }
    
    
    
    func testSigningOut() {
        XCTAssert(profileButton.waitForExistence(timeout: 5))
        profileButton.tap()
        
        XCTAssert(app.tables.staticTexts["SingOut"].waitForExistence(timeout: 5))
        app.tables.staticTexts["SingOut"].tap()
        
        XCTAssert(app.sheets["SignOut"].scrollViews.otherElements.buttons["Ok"].waitForExistence(timeout: 5))
        app.sheets["SignOut"].scrollViews.otherElements.buttons["Ok"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
