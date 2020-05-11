//
//  Papp_iOSUITests.swift
//  Papp-iOSUITests
//
//  Created by Anders la Cour Lønborg on 27/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//
import XCTest

class SignViewControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // MARK: Make the login session expire
        
    }

    func testLogin() throws {
        // UI tests must launch the application that they test.
        let validEmail = "test@test.dk"
        let validPassword = "tester"
        
        let app = XCUIApplication()
        app.launch()
        
        let validEmailTextField = app.textFields["Email"]
        XCTAssertTrue(validEmailTextField.exists)
        validEmailTextField.tap()
        validEmailTextField.typeText(validEmail)
        
        let passwordTextField = app.secureTextFields["Adgangskode"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(validPassword)
        
        app.buttons["Log På"].tap()
        
        let homeButton = app.buttons["Hjem"]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: homeButton, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoginWithKeyboard() throws {
           // UI tests must launch the application that they test.
           let validEmail = "test@test.dk"
           let validPassword = "tester"
           
           let app = XCUIApplication()
           app.launch()
           
           let validEmailTextField = app.textFields["Email"]
           XCTAssertTrue(validEmailTextField.exists)
           validEmailTextField.tap()
           validEmailTextField.typeText(validEmail)
           
           let passwordTextField = app.secureTextFields["Adgangskode"]
           XCTAssertTrue(passwordTextField.exists)
           app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"Næste\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
           passwordTextField.typeText(validPassword)
           
           app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"OK\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
           
           let homeButton = app.buttons["Hjem"]
           
           expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: homeButton, handler: nil)
           waitForExpectations(timeout: 5, handler: nil)
        
           // Use recording to get started writing UI tests.
           // Use XCTAssert and related functions to verify your tests produce the correct results.
       }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
