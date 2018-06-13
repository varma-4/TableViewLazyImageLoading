//
//  CodingAssignmentTests.swift
//  CodingAssignmentTests
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import XCTest
@testable import CodingAssignment

class CodingAssignmentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewControllerLoading() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: HomeTableViewController())
        XCTAssertNotNil(window.rootViewController, "HomeViewController cannot be instantiated")
    }
    
    func testTableViewComponents() {
        let homeVC = HomeTableViewController()
        _ = homeVC.view
        XCTAssertNotNil(homeVC.tableView, "TableView is not available")
        XCTAssertEqual(homeVC.tableView.backgroundColor, UIColor.white, "TableView is displaying some other background color")
        XCTAssertEqual(homeVC.itemsList.count, 0, "Count should be zero when opened for the first time")
        XCTAssertNotNil(homeVC.refreshControl, "refreshControl shouldn't be nil")
        XCTAssertNotNil(homeVC.tableView.tableFooterView, "TableViewFooterView shouldn't be nil")
    }
    
}
