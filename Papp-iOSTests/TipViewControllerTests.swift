//
//  TipViewControllerTests.swift
//  Papp-iOSTests
//
//  Created by Anders la Cour Lønborg on 27/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//
import XCTest

@testable import Papp_iOS
import Mapbox


class TipViewControllerTests: XCTestCase {
    
    var sut: TipViewController!
    var mapView: MGLMapView!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let pin: MGLPointAnnotation? = MGLPointAnnotation()
        pin?.coordinate = CLLocationCoordinate2D(latitude: 55.797180, longitude: 12.481905)
        
        
        mapView = MGLMapView(frame: CGRect(x: 0, y: 0, width: 414, height: 813))
        mapView.setCenter(CLLocationCoordinate2D(latitude: 55.31, longitude: 12.06), zoomLevel: 10, animated: false)
        mapView.addAnnotation(pin!)
        let mapVC: MapViewController = MapViewController()
        sut = TipViewController(mapVC)
        
        sut.mapViewForSnapshot = mapView
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testCreateSnapshot() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        sut.createSnapshot()
        let expectation = XCTestExpectation(description: "Create map snapshot")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0){
            XCTAssertNotNil(self.sut.snapShotImageView.image)
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 15)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
