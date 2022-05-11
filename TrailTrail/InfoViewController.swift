//
//  InfoViewController.swift
//  TrailTrail
//
//  Created by Christopher Su on 5/6/22.
//

import UIKit
import MapKit

class InfoViewController: UIViewController {

    // this is for the networking call
    let networking = Networking()
    // map creations
    let map = Map()
    // this is what contains the info
    @IBOutlet weak var events: UILabel!
    @IBOutlet weak var trails: UILabel!
    @IBOutlet weak var guide: UILabel!
    
    var attributes = AttributesSpec(name:"",longitude: 0,latitude: 0,slug:"",google_events_url: "",alltrails_url: "", url: "")
    // this is from the segue
    var location: String?
        
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var name: UILabel!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        guard let location = location else {
            return
        }
        // set default region to sf
        mapView.setRegion(map.createDefaultMap(), animated: true)
        
        networking.fetchInfo( callback: { info2 in
            self.update(with: info2)
        }, location:location)
    }
    
    func update(with info2: SpecDati) {
        DispatchQueue.main.async {
            // remember to error check
            if(info2.id != "0") {
                // set the data if there is no errors!
                self.attributes = info2.attributes

                // set the label
                self.name.text = self.attributes.name
                self.events.text = "Events: " + self.attributes.google_events_url
                self.trails.text = "Trails: " + self.attributes.alltrails_url
                self.guide.text = "Travel Guide: " + self.attributes.url

                // set the map
                self.mapView.setRegion(self.map.createMap(location: self.attributes), animated: true)
                self.mapView.addAnnotation(self.map.makePin(location: self.attributes))
            } else {
                self.name.text = "INVALID INPUT :( TRY AGAIN!!"
                print("Did not find a location")
            }
        }
    }


}
