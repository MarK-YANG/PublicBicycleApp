//
//  RentOrderDetailTableViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/12/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class RentOrderDetailTableViewController: BlueUITableViewController {
    
    var orderDetail: NSDictionary?
    
    @IBOutlet weak var OrderId: UILabel!
    @IBOutlet weak var CustomerId: UILabel!
    @IBOutlet weak var CustomerName: UILabel!
    @IBOutlet weak var RentStationName: UILabel!
    @IBOutlet weak var FinishStationName: UILabel!
    @IBOutlet weak var StartTime: UILabel!
    @IBOutlet weak var FinishTime: UILabel!
    @IBOutlet weak var Cost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.OrderId.text = orderDetail?.valueForKey("id") as? String
        self.CustomerId.text = orderDetail?.valueForKey("customer_id") as? String
        self.CustomerName.text = orderDetail?.valueForKey("customer_name") as? String
        self.RentStationName.text = orderDetail?.valueForKey("rent_station_name") as? String
        self.FinishStationName.text = orderDetail?.valueForKey("return_station_name") as? String
        self.StartTime.text = orderDetail?.valueForKey("start_time") as? String
        self.FinishTime.text = orderDetail?.valueForKey("finish_time") as? String
        let str = orderDetail?.valueForKey("cost") as? String
        self.Cost.text = str! + " 元"
        self.Cost.textColor = UIColor.orangeColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
