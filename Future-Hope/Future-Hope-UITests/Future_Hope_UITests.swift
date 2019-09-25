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
    
    var profileTabBarButton: XCUIElement {
        return app.tabBars.buttons["Profile"]
    }
    
    var messagesTabBarButton: XCUIElement {
        return app.tabBars.buttons["Messages"]
    }
    
    var exploreTabBarButton: XCUIElement {
        return app.tabBars.buttons["Explore"]
    }
    
    var myScheduleTabBarButton: XCUIElement {
        return app.tabBars.buttons["MySchedule"]
    }
    
    override func setUp() {
        continueAfterFailure = false
    }
    
    func testSigningOut() {
        XCTAssert(profileTabBarButton.waitForExistence(timeout: 5))
        profileTabBarButton.tap()
        
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
