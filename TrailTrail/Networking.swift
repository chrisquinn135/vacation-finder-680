//
//  Networking.swift
//  TrailTrail
//
//  Created by Christopher Su on 5/6/22.
//

import Foundation


// This is the networking call
struct Networking {
    
    let baseURLString = "https://api.roadgoat.com/api/v2/destinations/auto_complete?q="
    
    let baseURLStringCall2 = "https://api.roadgoat.com/api/v2/destinations/"
    
    
    func fetchInfo(callback: @escaping (SpecDati) -> (),location: String) {
        // This would block user interactons, we want to do this on a background queue.
        
        // build the url based on user input
        let loc = location.lowercased().replacingOccurrences(of: " ", with: "-")
        // Make the url based on the input
        let url = URL(string: "\(baseURLString)\(loc)")!
        var request = URLRequest(url: url)
        let authData = ("d3171df05b97abf67b97a1ff1d7483f1" + ":" + "e149c445718433c51c2ffd49c7de77b4").data(using: .utf8)!.base64EncodedString()
        request.httpMethod = "GET"
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")

        // make api call to get auto-complete responses to the input
        let task = URLSession.shared.dataTask(with: request) { maybeData, maybeResponse, maybeError in
            guard let data: Data = maybeData else {
                print("ERROR")
                return
            }
            
            // decode the response
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(Info.self, from: data)
                let Info: Info = response
              
                if(Info.data.count > 0) {
                    // network call 2 based on the slug from the first network call that we got back
                    let url2 = URL(string: "\(baseURLStringCall2)\(Info.data[0].attributes.slug)")!
                    var request2 = URLRequest(url: url2)
                    let authData = ("d3171df05b97abf67b97a1ff1d7483f1" + ":" + "e149c445718433c51c2ffd49c7de77b4").data(using: .utf8)!.base64EncodedString()
                    request2.httpMethod = "GET"
                    request2.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
                    print(url2)
                    
                    // api call 2 to get the specialized data of the location
                    
                    // network call 2 based on the slug from the first network call that we got back Info.data[0].attributes.slug
                    
                    let task2 = URLSession.shared.dataTask(with: request2) { maybeData, maybeResponse, maybeError in
                        print("TASK IS RNA")
                        guard let data: Data = maybeData else {
                            print("ERROR")
                            return
                        }
            //            print(String(data: data, encoding: .utf8))
                        let decoder = JSONDecoder()
                        do {
                            let response = try decoder.decode(Spec.self, from: data)
                            print("SUCCESS for 2!")
                            let Spec: Spec = response
                            
                            print("NETWORK Spec ")
                            print(Spec.data.attributes.name)

                            
                            
                            callback(Spec.data)
                        } catch {
                            print("THERE WAS EROORRO")
                        }
                    }
                    task2.resume()
                } else {
                    let errorAtt = AttributesSpec(name:"",longitude: 0,latitude: 0,slug:"",google_events_url: "",alltrails_url: "",url:"")
                    let error = SpecDati(id:"0", attributes: errorAtt)
                    callback(error)
                }
                
                
            } catch {

            }
        }
        task.resume()
    }
    
        
}
