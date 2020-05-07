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
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let app = XCUIApplication()
        if !app.staticTexts["Test"].exists && !app.staticTexts["Danmark"].exists && app.navigationBars["Min Profil"].buttons["Rediger"].exists {
            
            app.navigationBars["Min Profil"].buttons["Rediger"].tap()
            
            let redigerBeskrivelsesText = app.textFields["Skriv din beskrivelse her"]
            redigerBeskrivelsesText.tap()
            redigerBeskrivelsesText.typeText("Test")
            
            app.pickerWheels.element.adjust(toPickerWheelValue: "Danmark")
            
            app.children(matching: .window).element(boundBy: 0).tap()
            
            app/*@START_MENU_TOKEN@*/.staticTexts["Rediger Profil"]/*[[".buttons[\"Rediger Profil\"].staticTexts[\"Rediger Profil\"]",".staticTexts[\"Rediger Profil\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
    }

    func testEditProfile() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.tabBars.buttons["Menu"].tap()
        
        app.tables.cells.element(matching: .cell, identifier: "Min Profil").tap()
        
        let redigerButton = app.navigationBars["Min Profil"].buttons["Rediger"]
        redigerButton.tap()
        
        let redigerBeskrivelsesText = app.textFields["Skriv din beskrivelse her"]
        redigerBeskrivelsesText.tap()
        redigerBeskrivelsesText.typeText("Første test beskrivelse")
        
        app.pickerWheels.element.adjust(toPickerWheelValue: "Deutschland")
        
        let element = app.children(matching: .window).element(boundBy: 0)
        element.tap()
        
        let redigerProfilStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Rediger Profil"]/*[[".buttons[\"Rediger Profil\"].staticTexts[\"Rediger Profil\"]",".staticTexts[\"Rediger Profil\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        redigerProfilStaticText.tap()
        
        XCTAssertTrue(app.staticTexts["Første test beskrivelse"].exists)
        XCTAssertTrue(app.staticTexts["Deutschland"].exists)
        
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
        
    }

}
