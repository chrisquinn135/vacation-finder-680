//
//  Info.swift
//  TrailTrail
//
//  Created by Christopher Su on 5/6/22.
//

import Foundation

// this is for first api call, just getting autocomplete information
struct Info: Codable {
    var data: [Dati]
}

struct Dati: Codable {
    var id: String
    var attributes: Attributes
//    var attributes: Attributes
}

struct Attributes: Codable {
    var slug: String
}


// This is for the specific location (2nd api call)
struct Spec: Codable {
    var data: SpecDati
}

struct SpecDati: Codable {
    var id: String
    var attributes: AttributesSpec
}

struct AttributesSpec: Codable {
    let name: String
    var longitude: Double
    var latitude: Double
    var slug: String
    var google_events_url: String
    var alltrails_url: String
    var url: String
}
