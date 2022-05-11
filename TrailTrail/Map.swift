//
//  Map.swift
//  TrailTrail
//
//  Created by Christopher Su on 5/7/22.
//

import Foundation
import MapKit

struct Map {
    
    func createDefaultMap() -> MKCoordinateRegion {
        let region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 37.77491, longitude: -122.4194),span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        return region
    }
    func createMap(location: AttributesSpec) -> MKCoordinateRegion{
        let region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        return region
    }
    func makePin(location: AttributesSpec) -> MKPointAnnotation{
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        return pin
    }
    
}
