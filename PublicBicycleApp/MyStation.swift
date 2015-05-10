//
//  Station.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/10/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class MyStation {
    var bike_count:Int
    var parkingspace_count:Int
    var station_address:String
    var station_id:String
    var station_name:String
    var station_phone_num: String
    
    init(){
        self.bike_count = 0
        self.parkingspace_count = 0
        self.station_address = ""
        self.station_id = ""
        self.station_name = ""
        self.station_phone_num = ""
    }
}