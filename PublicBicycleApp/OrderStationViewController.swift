//
//  OrderStationViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/10/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//


import UIKit

class OrderStationViewController: BlueUIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var stationArray: [MyStation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllStation()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell : UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("stationInfoCell") as! UITableViewCell
    
        
        return cell
    }
    
    func getAllStation(){
        var http: HttpRequest = HttpRequest()
        http.URL = "test.php"
        http.parameters = ["Hello":"NIHAO"]
        http.requestType = "POST"
        
        
                
    }

}