//
//  MapViewDelegate.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 28/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import Foundation
import UIKit
import Mapbox


extension MapViewController {
    
    // MARK: - MGLMapViewDelegate
     
     func mapView(_ mapView: MGLMapView, regionWillChangeAnimated animated: Bool){
         
         if mapView.userTrackingMode == .none {
             trackButton.setImage(UIImage(systemName: "location"), for: .normal)
         }
     }
     
     func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
         mStyle = style
         fireStoreController.getAllPVagt(mapView,style)
         fireStoreController.getAllPTips(mapView, style)
     }
     
     func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
         return true
     }
     
     
     func mapView(_ mapView: MGLMapView, didDeselect annotation: MGLAnnotation) {
         mapView.removeAnnotations([annotation])
     }
     
     
     func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
         
         if GlobalVariables.previousItem == 0 {
             
             // Create an empty view annotation. Set a frame to offset the callout.
             return MGLAnnotationView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
         }
         return nil
     }
    
    //MARK: - Public methods
    
    @objc @IBAction func handleMapTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            // Limit feature selection to just the following layer identifiers.
            let layerIdentifiers: Set = ["tip-style"]
            
            // Try matching the exact point first.
            let point = sender.location(in: sender.view!)
            for feature in mapView.visibleFeatures(at: point, styleLayerIdentifiers: layerIdentifiers)
                where feature is MGLPointFeature {
                    guard let selectedFeature = feature as? MGLPointFeature else {
                        fatalError("Failed to cast selected feature as MGLPointFeature")
                    }
                    showCallout(feature: selectedFeature)
                    return
            }
            
            let touchCoordinate = mapView.convert(point, toCoordinateFrom: sender.view!)
            let touchLocation = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
            
            // Otherwise, get all features within a rect the size of a touch (44x44).
            let touchRect = CGRect(origin: point, size: .zero).insetBy(dx: -22.0, dy: -22.0)
            let possibleFeatures = mapView.visibleFeatures(in: touchRect, styleLayerIdentifiers: Set(layerIdentifiers)).filter { $0 is MGLPointFeature }
            
            // Select the closest feature to the touch center.
            let closestFeatures = possibleFeatures.sorted(by: {
                return CLLocation(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude).distance(from: touchLocation) < CLLocation(latitude: $1.coordinate.latitude, longitude: $1.coordinate.longitude).distance(from: touchLocation)
            })
            if let feature = closestFeatures.first {
                guard let closestFeature = feature as? MGLPointFeature else {
                    fatalError("Failed to cast selected feature as MGLPointFeature")
                }
                showCallout(feature: closestFeature)
                return
            }
            
            // If no features were found, deselect the selected annotation, if any.
            mapView.deselectAnnotation(mapView.selectedAnnotations.first, animated: true)
        }
        
        
        
    }
    
    func showCallout(feature: MGLPointFeature) {
        let point = MGLPointFeature()
        point.title = feature.attributes["description"] as? String
        point.coordinate = feature.coordinate
        
        // Selecting an feature that doesn’t already exist on the map will add a new annotation view.
        // We’ll need to use the map’s delegate methods to add an empty annotation view and remove it when we’re done selecting it.
        mapView.selectAnnotation(point, animated: true, completionHandler: nil)
    }
    
    @objc @IBAction func handlePinMapTap(sender: UITapGestureRecognizer) {
        let tapPoint: CGPoint = sender.location(in: mapView)
        let coordinate: CLLocationCoordinate2D = mapView.convert(tapPoint, toCoordinateFrom: nil)
        
        
        if pin?.coordinate != nil {
            mapView.removeAnnotation(pin!)
            pin!.coordinate = coordinate
            mapView.addAnnotation(pin!)
        }
        else {
            
            pin!.coordinate = coordinate
            
            let shapeSource = MGLShapeSource(identifier: "marker-source", shape: pin, options: nil)
            
            let shapeLayer = MGLSymbolStyleLayer(identifier: "marker-style", source: shapeSource)
            
            mStyle.addSource(shapeSource)
            mStyle.addLayer(shapeLayer)
            mapView.addAnnotation(pin!)
        }
    }
    
    func enableTipMapTap() {
        onTipTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            onTipTapRecognizer.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(onTipTapRecognizer)
    }
    
    func disableTipMapTap () {
        mapView.removeGestureRecognizer(onTipTapRecognizer)
    }
    
    
}
