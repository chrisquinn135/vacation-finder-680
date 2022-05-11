//
//  ViewController.swift
//  TrailTrail
//
//  Created by Christopher Su on 5/5/22.
//

import UIKit

class ViewController: UIViewController {

    let networking = Networking()
        
    @IBOutlet weak var location: UITextField!
    
    @IBAction func button(_ sender: UIButton) {
        let userInput: String? = location.text
        if let stringInput = userInput {
            print(stringInput)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let InfoViewController = segue.destination as? InfoViewController else {
            return
        }
        InfoViewController.location = location.text
        print(segue.destination)
    }
}

