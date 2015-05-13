//
//  FinishOrderDetailTableViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/12/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class FinishOrderDetailTableViewController: BlueUITableViewController {
    
    var orderDetail: NSDictionary?
    var orderType: Int?
    
    
    @IBOutlet weak var OrderTitle: UILabel!
    @IBOutlet weak var OrderId: UILabel!
    @IBOutlet weak var CustomerId: UILabel!
    @IBOutlet weak var CustomerName: UILabel!
    @IBOutlet weak var StationName: UILabel!
    @IBOutlet weak var StartTime: UILabel!
    @IBOutlet weak var FinishTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if orderType == 2 {
            self.OrderTitle.text = "历史自行车预约订单"
        }else if orderType == 3 {
            self.OrderTitle.text = "历史停车位预约订单"
        }
        
        self.OrderId.text = orderDetail?.valueForKey("id") as? String
        self.CustomerId.text = orderDetail?.valueForKey("customer_id") as? String
        self.CustomerName.text = orderDetail?.valueForKey("customer_name") as? String
        self.StationName.text = orderDetail?.valueForKey("station_name") as? String
        self.StartTime.text = orderDetail?.valueForKey("start_time") as? String
        self.FinishTime.text = orderDetail?.valueForKey("finish_time") as? String
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
