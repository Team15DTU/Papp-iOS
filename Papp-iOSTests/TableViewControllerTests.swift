//
//  TableViewControllerTests.swift
//  Papp-iOSTests
//
//  Created by Anders la Cour Lønborg on 09/05/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import XCTest
@testable import Papp_iOS

class TableViewControllerTests: XCTestCase {

    var sut: TableViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "tableViewController") as? TableViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testTableViewCells() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tableView = sut.tableView
        
        XCTAssertNotNil(tableView, "no table view found")
        
        for i in 0...4{
            let cell = sut.tableView(tableView!, cellForRowAt: IndexPath(row: i, section: 0))
            XCTAssertNotNil(cell, "No cell at row \(i) (number of rows start at 0)")
            XCTAssertNotNil(cell.imageView, "No image view in table cell on row \(i) (number of rows start at 0)")
            XCTAssertNotNil(cell.textLabel, "No textn label in table cell on row \(i) (number of rows start at 0)")
        }
    }
}
