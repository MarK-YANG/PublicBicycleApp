//
//  StationViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/10/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//


import UIKit

class StationViewController: BlueUIViewController, UITableViewDataSource {
    
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
        return self.stationArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell : UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("stationInfoCell") as! UITableViewCell
        
        var station = self.stationArray[indexPath.row] as MyStation
        var station_name = cell.viewWithTag(101) as! UILabel
        var station_address = cell.viewWithTag(102) as! UILabel
        
        station_name.text = station.station_name
        station_address.text = station.station_address
        
        
        return cell
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailStationInfo"{
            var vc = segue.destinationViewController as! StationInfoViewController
            var indexPath = tableView.indexPathForSelectedRow()
            if let index = indexPath {
                vc.station = stationArray[index.row]
            }
        }
    }
    
    
    func getAllStation(){
        
        var http = HttpRequest(url: "station.php", parameters: ["tag": "allStationStatus"])
        var json = http.getJsonDecode()
        if(json.valueForKey("error") as! Int == 0){
            
            let stationArray = json.valueForKey("stationStatus") as! NSArray
            
            for station in stationArray{
                let dicStation = station as! NSDictionary
                var iStation = MyStation(bike_count: dicStation["available_bike_count"] as! Int, parkingspace_count: dicStation["available_parkingspace_count"] as! Int,
                    station_address: dicStation["station_address"] as! String,
                    station_id: dicStation["station_id"] as! String,
                    station_name: dicStation["station_name"] as! String,
                    station_phone_num: dicStation["station_phone_number"] as! String)
                self.stationArray.append(iStation)
            }
            
        }else{
            //open an error window
        }
    }

}