//
//  Future_Hope_UnitTests.swift
//  Future-Hope-UnitTests
//
//  Created by HSV on 9/24/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//





@testable import Future_Hope

import XCTest
import UIKit


class Future_Hope_UnitTests: XCTestCase {
    let hectorVillAccountUID = "iDh1XGoJ6EM36wK8SyQSOuOjDwH3"
    let meetingUID = "ohrbvzOZ8SX1uZFxKTUg" // from firebase
    let firecontrol = FireStoreController()
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testFirestoreReference() {
        XCTAssertTrue(FireStoreController.users == "users")
        XCTAssertTrue(FireStoreController.meetings == "meetings")
    }

    func testFirestorefetchMeetings() {
        firecontrol.fetchMyMeetings(with: hectorVillAccountUID) { _, error in
            if let error = error {
                XCTAssert(false, error.localizedDescription)
            }
        }
    }
    
    func testFirestoreFetchAllTeachers() {
        firecontrol.fetchAllTeachers { _, error in
            if let error = error {
                XCTAssert(false, error.localizedDescription)
            }
        }
    }
    
    

}
