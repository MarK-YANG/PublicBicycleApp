//
//  Station.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/10/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class MyStation: NSObject {
    var bike_count:Int
    var parkingspace_count:Int
    var station_address:String
    var station_id:String
    var station_name:String
    var station_phone_num: String
    
    override init(){
        self.bike_count = 0
        self.parkingspace_count = 0
        self.station_address = ""
        self.station_id = ""
        self.station_name = ""
        self.station_phone_num = ""
    }
    
    init(bike_count: Int, parkingspace_count: Int, station_address: String, station_id: String, station_name: String, station_phone_num: String) {
        self.bike_count = bike_count
        self.parkingspace_count = parkingspace_count
        self.station_address = station_address
        self.station_id = station_id
        self.station_name = station_name
        self.station_phone_num = station_phone_num
    }
}