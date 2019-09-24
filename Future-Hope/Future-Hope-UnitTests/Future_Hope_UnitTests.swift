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
    let uuid = UUID().uuidString
    let firecontrol = FireStoreController()
    
    var testMetting: Meeting {
        return Meeting(id: uuid, participantNames: ["Hector", "Thomas"], participantUIDs: [UUID().uuidString, UUID().uuidString], start: Date(), title: "This is a meeting")
    }
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testFirestoreReference() {
        XCTAssertTrue(FireStoreController.users == "users")
        XCTAssertTrue(FireStoreController.meetings == "meetings")
    }

    
    func testFetchingmettings() {
        firecontrol.fetchMyMeetings(with: "") { _, error in
            if let error = error {
                XCTAssert(false, error.localizedDescription)
            }
        }
        
        
    }
    

}
