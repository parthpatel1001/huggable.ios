//
//  ReunionViewController.swift
//  Huggable
//
//  Created by Parth Patel on 2/14/15.
//  Copyright (c) 2015 Huggable.io. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReunionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var airline = "";
    var flight_num = "";
    var items: [String] = ["We", "Heart", "Swift"];

    @IBOutlet var flightList: UITableView!
    @IBOutlet weak var airlineTest: UILabel!
    @IBOutlet weak var flightTest: UILabel!
    
    override func viewDidLoad() {
        //call the parent
        super.viewDidLoad()

        //set the title of the page
        title = "huggable"
        
        //set the labels for the input....ask joe if we want it on the page
        airlineTest.text = self.airline
        flightTest.text = self.flight_num
        
        //ask the server for the flight information
        //should we validate here or before..(?)
        Alamofire.request(
            .GET,
            "http://huggable.io/flights", //move this to a constant
            parameters:[ //pass the parameters from the vars set in the "constructor"
                "airline":self.airline,
                "flight_num":self.flight_num
            ]).responseJSON { (_,_,JSONRESULT,_) in
                
                //cast the json
                let flights = JSON(JSONRESULT!)

                //reset the items list
                self.items = [];
                //go through the results from the server and cast it
                for (index: String,singleFlight: JSON) in flights {

                    let dest_air  = singleFlight["dest_airport"].string!;
                    let from_air  = singleFlight["from_airport"].string!;
                    let ariv_time = singleFlight["arrive_time"].int!;
                    let dep_time  = singleFlight["depart_time"].int!;
                    let faId      = singleFlight["faId"].string!;
                    
                    //add the items to the list
                    self.items.append("\(dest_air) - \(from_air)");
                    //convert from unix timestamp to readable dates
                    self.items.append("\(dep_time) - \(ariv_time)");
                    //faId might not need to be there
                    self.items.append("[\(faId)]");
                }
                self.flightList.reloadData();
            };
        
        //register the UiTable fxns
        self.flightList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //wtf is this shit
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //here send variables to the next control
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

    //implement UITableView interface
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    //implement UITableView interface
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.flightList.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
    
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }

    //implement UITableView interface
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //here add way to click to see the hug icon and stuff
        println("You selected cell #\(indexPath.row)!")
    }
    


}
