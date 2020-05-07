//
//  EditProfileViewControllerTests.swift
//  Papp-iOSUITests
//
//  Created by Anders la Cour Lønborg on 07/05/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import XCTest

class EditProfileViewControllerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        // Open the side menu and go to the "Min Profil" section on test startup
        app.tabBars.buttons["Menu"].tap()
        app.tables.cells.element(matching: .cell, identifier: "Min Profil").tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let app = XCUIApplication()
        // If the profiles description is not "Test" and the country not "Danmark", change it.
        if !app.staticTexts["Test"].exists && !app.staticTexts["Danmark"].exists {
            
            app.navigationBars["Min Profil"].buttons["Rediger"].tap()
            
            let redigerBeskrivelsesText = app.textFields["Skriv din beskrivelse her"]
            redigerBeskrivelsesText.tap()
            redigerBeskrivelsesText.typeText("Test")
            
            app.pickerWheels.element.adjust(toPickerWheelValue: "Danmark")
            
            app.children(matching: .window).element(boundBy: 0).tap()
            
            app.staticTexts["Rediger Profil"].tap()
        }
    }

    func testEditProfile() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        
        // Go to the profile editing view
        let redigerButton = app.navigationBars["Min Profil"].buttons["Rediger"]
        redigerButton.tap()
        
        // Write the first description test
        let redigerBeskrivelsesText = app.textFields["Skriv din beskrivelse her"]
        redigerBeskrivelsesText.tap()
        redigerBeskrivelsesText.typeText("Første test beskrivelse")
        
        // Pick the country "Deutschland"
        app.pickerWheels.element.adjust(toPickerWheelValue: "Deutschland")
        
        // Remove the keyboard
        let element = app.children(matching: .window).element(boundBy: 0)
        element.tap()
        
        // Save the changes
        let redigerProfilStaticText = app.staticTexts["Rediger Profil"]
        redigerProfilStaticText.tap()
        
        // Check if the profile has the correct data
        XCTAssertTrue(app.staticTexts["Første test beskrivelse"].exists)
        XCTAssertTrue(app.staticTexts["Deutschland"].exists)
        
        // Repeat the test with different information to make sure it's working as intended
        redigerButton.tap()
        
        redigerBeskrivelsesText.tap()
        redigerBeskrivelsesText.typeText("Anden test beskrivelse")
        app.pickerWheels.element.adjust(toPickerWheelValue: "Sverige")
        
        element.tap()
        redigerProfilStaticText.tap()
        
        XCTAssertTrue(app.staticTexts["Anden test beskrivelse"].exists)
        XCTAssertTrue(app.staticTexts["Sverige"].exists)
    }
    
    func testEditProfileWithNothing() throws {
        let app = XCUIApplication()
        
        // Go to the profile editing view
        let redigerButton = app.navigationBars["Min Profil"].buttons["Rediger"]
        redigerButton.tap()
        
        // Write the first description test
        let redigerBeskrivelsesText = app.textFields["Skriv din beskrivelse her"]
        redigerBeskrivelsesText.tap()
        redigerBeskrivelsesText.typeText("Dette er en test")
               
        // Pick the country "France"
        app.pickerWheels.element.adjust(toPickerWheelValue: "France")
               
        // Remove the keyboard
        let element = app.children(matching: .window).element(boundBy: 0)
        element.tap()
               
        // Save the changes
        let redigerProfilStaticText = app.staticTexts["Rediger Profil"]
        redigerProfilStaticText.tap()
        
        // Go to the profile editing view and without editing anything click "Rediger Profil"
        redigerButton.tap()
        redigerProfilStaticText.tap()
        
        // Check if the profile information changed
        XCTAssertTrue(app.staticTexts["Dette er en test"].exists)
        XCTAssertTrue(app.staticTexts["France"].exists)
    }
}
