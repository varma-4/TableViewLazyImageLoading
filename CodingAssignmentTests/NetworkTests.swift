//
//  NetworkTests.swift
//  CodingAssignmentTests
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import XCTest
@testable import CodingAssignment

class NetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWhetherNetworkCanGetData() {
        let homeVC = HomeTableViewController()
        _ = homeVC.view
        
        homeVC.fetchItems()
        XCTAssertEqual(homeVC.itemsList.count, 0, "As Network call is Asynchronous, update should take approx more than 1/2 second time")
        let predicate = NSPredicate { (_
            , _) -> Bool in
            return homeVC.itemsList.count > 0
        }
        
        let _ = expectation(for: predicate, evaluatedWith: homeVC, handler: nil)
        
        waitForExpectations(timeout: 20) { (error) in
            if let error = error {
                print(error.localizedDescription)
                XCTFail("NetworkManager is taking more time to fetch data from server")
            }
        }
    }
    
    func testWhetherImageCachingIsDone() {
        let homeVC = HomeTableViewController()
        _ = homeVC.view
        let randomImageStringFromJSON = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        
        homeVC.fetchItems()
        let predicate = NSPredicate { (_
            , _) -> Bool in
            return homeVC.itemsList.count > 0 && (imageCache.object(forKey: randomImageStringFromJSON as AnyObject) != nil)
        }
        
        let _ = expectation(for: predicate, evaluatedWith: homeVC, handler: nil)
        
        waitForExpectations(timeout: 20) { (error) in
            if let error = error {
                print(error.localizedDescription)
                XCTFail("NetworkManager is taking more time to fetch data from server")
            }
        }
    }
    
}
