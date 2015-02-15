//
//  ViewController.swift
//  Huggable
//
//  Created by Parth Patel on 2/14/15.
//  Copyright (c) 2015 Huggable.io. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController
//    , UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var flightInput: UITextField!
    @IBOutlet weak var airlineInput: UITextField!
    
    @IBOutlet weak var viewFlights: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        title = "huggable"
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    
    func setupUI() {
//        airlineInput.text = "Airline"
//        flightInput.text = "Flight"

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let reuinionController = segue.destinationViewController as ReunionViewController
        reuinionController.flight_num = flightInput.text
        reuinionController.airline = airlineInput.text
    }

}

