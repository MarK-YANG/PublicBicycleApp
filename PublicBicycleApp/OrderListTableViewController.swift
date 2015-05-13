//
//  OrderDetailViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/12/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class OrderListTableViewController: BlueUIViewController, UITableViewDataSource {
    
    var OrderType: Int?
    var emptyFlag = 0
    var orderArray: NSArray?
    var customerId: String?

    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getCustomerId
//         self.customerId = "test@test.com"
        self.customerId = "emp.yangchunyu@gmail.com"
        
        if OrderType == 2 {
            
            let result =  getFinishBikeBookOrder(customerId!)
            
            if result.count == 0 {
                emptyFlag = 1
            }else{
                orderArray = result
            }
            
        }else if OrderType == 3{
            
            let result =  getFinishParkingspaceBookOrder(customerId!)
            
            if result.count == 0 {
                emptyFlag = 1
            }else{
                orderArray = result
            }
            
        }else if OrderType == 4{
            let result =  getFinishRentOrder(customerId!)
            
            if result.count == 0 {
                emptyFlag = 1
            }else{
                orderArray = result
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if emptyFlag == 1 {
            return 1
        }else{
            return self.orderArray!.count + 1
        }
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if self.OrderType == 2{
            if indexPath.row == 0 {
                var cell : UITableViewCell = self.myTableView.dequeueReusableCellWithIdentifier("OderListTitle") as! UITableViewCell
                var image = cell.viewWithTag(101) as! UIImageView
                var title = cell.viewWithTag(102) as! UILabel
                var customerId = cell.viewWithTag(103) as! UILabel
                var customerName = cell.viewWithTag(104) as! UILabel
                image.image = UIImage(named: "HistoricalBikeOrder")
                title.text = "历史预约自行车订单"
                
                if emptyFlag == 1 {
                    customerId.text = "没有查询到历史自行车预约订单"
                    customerId.textColor = UIColor.orangeColor()
                    customerName.text = ""
                }else{
                    var firstOrder = self.orderArray![0] as! NSDictionary
                    customerId.text = firstOrder.valueForKey("customer_id") as? String
                    customerName.text = firstOrder.valueForKey("customer_name") as? String
                }
                
                return cell
            }else{
                var cell : UITableViewCell = self.myTableView.dequeueReusableCellWithIdentifier("OderListContent2") as! UITableViewCell
                
                var orderId = cell.viewWithTag(101) as! UILabel
                var stationName = cell.viewWithTag(102) as! UILabel
                var startTime = cell.viewWithTag(103) as! UILabel
                var finishTime = cell.viewWithTag(104) as! UILabel
                
                let currentOrder = self.orderArray![indexPath.row-1] as? NSDictionary
                orderId.text = currentOrder?.valueForKey("id") as? String
                stationName.text = currentOrder?.valueForKey("station_name") as? String
                startTime.text = currentOrder?.valueForKey("start_time") as? String
                finishTime.text = currentOrder?.valueForKey("finish_time") as? String
                
                return cell
            }
        }else if self.OrderType == 3 {
            
            if indexPath.row == 0 {
                var cell : UITableViewCell = self.myTableView.dequeueReusableCellWithIdentifier("OderListTitle") as! UITableViewCell
                var image = cell.viewWithTag(101) as! UIImageView
                var title = cell.viewWithTag(102) as! UILabel
                var customerId = cell.viewWithTag(103) as! UILabel
                var customerName = cell.viewWithTag(104) as! UILabel
                image.image = UIImage(named: "HistoricalParkingspaceOrder")
                title.text = "历史预约停车位订单"
                
                if emptyFlag == 1 {
                    customerId.text = "没有查询到历史停车位预约订单"
                    customerId.textColor = UIColor.orangeColor()
                    customerName.text = ""
                }else{
                    var firstOrder = self.orderArray![0] as! NSDictionary
                    customerId.text = firstOrder.valueForKey("customer_id") as? String
                    customerName.text = firstOrder.valueForKey("customer_name") as? String
                }
                
                return cell
            }else{
                var cell : UITableViewCell = self.myTableView.dequeueReusableCellWithIdentifier("OderListContent2") as! UITableViewCell
                
                var orderId = cell.viewWithTag(101) as! UILabel
                var stationName = cell.viewWithTag(102) as! UILabel
                var startTime = cell.viewWithTag(103) as! UILabel
                var finishTime = cell.viewWithTag(104) as! UILabel
                
                let currentOrder = self.orderArray![indexPath.row-1] as? NSDictionary
                orderId.text = currentOrder?.valueForKey("id") as? String
                stationName.text = currentOrder?.valueForKey("station_name") as? String
                startTime.text = currentOrder?.valueForKey("start_time") as? String
                finishTime.text = currentOrder?.valueForKey("finish_time") as? String
                
                return cell
            }
            
        }else if self.OrderType == 4{
            if indexPath.row == 0 {
                var cell : UITableViewCell = self.myTableView.dequeueReusableCellWithIdentifier("OderListTitle") as! UITableViewCell
                var image = cell.viewWithTag(101) as! UIImageView
                var title = cell.viewWithTag(102) as! UILabel
                var customerId = cell.viewWithTag(103) as! UILabel
                var customerName = cell.viewWithTag(104) as! UILabel
                image.image = UIImage(named: "HistoricalParkingspaceOrder")
                title.text = "历史租车订单"
                
                if emptyFlag == 1 {
                    customerId.text = "没有查询到历史租车订单"
                    customerId.textColor = UIColor.orangeColor()
                    customerName.text = ""
                }else{
                    var firstOrder = self.orderArray![0] as! NSDictionary
                    customerId.text = firstOrder.valueForKey("customer_id") as? String
                    customerName.text = firstOrder.valueForKey("customer_name") as? String
                }
                
                return cell
            }else{
                var cell : UITableViewCell = self.myTableView.dequeueReusableCellWithIdentifier("OderListContent3") as! UITableViewCell
                
                var orderId = cell.viewWithTag(101) as! UILabel
                var rentStationName = cell.viewWithTag(102) as! UILabel
                var returnStationName = cell.viewWithTag(103) as! UILabel
                var startTime = cell.viewWithTag(104) as! UILabel
                var finishTime = cell.viewWithTag(105) as! UILabel
                
                let currentOrder = self.orderArray![indexPath.row-1] as? NSDictionary
                orderId.text = currentOrder?.valueForKey("id") as? String
                rentStationName.text = currentOrder?.valueForKey("rent_station_name") as? String
                returnStationName.text = currentOrder?.valueForKey("return_station_name") as? String
                startTime.text = currentOrder?.valueForKey("start_time") as? String
                finishTime.text = currentOrder?.valueForKey("finish_time") as? String
                
                return cell
            }

        }else{
            var cell : UITableViewCell = self.myTableView.dequeueReusableCellWithIdentifier("OderListContent1") as! UITableViewCell
            return cell
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GotoBookOrder" {
            var indexPath = self.myTableView.indexPathForSelectedRow()
            if let index = indexPath {
                if index.row != 0 {
                    var vc = segue.destinationViewController as! FinishOrderDetailTableViewController
                    var indexArray = index.row - 1
                    let array = self.orderArray![indexArray] as? NSDictionary
                    vc.orderDetail = array
                    vc.orderType = self.OrderType
                }
            }
        }else if segue.identifier == "GotoRentOrder" {
            var indexPath = self.myTableView.indexPathForSelectedRow()
            if let index = indexPath {
                if index.row != 0 {
                    var vc = segue.destinationViewController as! RentOrderDetailTableViewController
                    var indexArray = index.row - 1
                    let array = self.orderArray![indexArray] as? NSDictionary
                    vc.orderDetail = array
                }
            }
        }
    }

    func getFinishBikeBookOrder(customerId: String)-> NSArray{
        let request = HttpRequest(url: "historicalOrder.php", parameters: ["tag": "bike", "customer_id": customerId])
        
        let json = request.getJsonDecode()
        let errorMsg = json.valueForKey("error") as? Int
        
        if errorMsg == 1{
            return NSArray()
        }else{
            let order = json.valueForKey("bike") as! NSArray
            return order
        }
        
    }
    
    func getFinishParkingspaceBookOrder(customerId: String)-> NSArray{
        let request = HttpRequest(url: "historicalOrder.php", parameters: ["tag": "parkingspace", "customer_id": customerId])
        
        let json = request.getJsonDecode()
        let errorMsg = json.valueForKey("error") as? Int
        
        if errorMsg == 1{
            return NSArray()
        }else{
            let order = json.valueForKey("parkingspace") as! NSArray
            return order
        }
    }

    func getFinishRentOrder(customerId: String)-> NSArray{
        let request = HttpRequest(url: "historicalOrder.php", parameters: ["tag": "rent", "customer_id": customerId])
        
        let json = request.getJsonDecode()
        let errorMsg = json.valueForKey("error") as? Int
        
        if errorMsg == 1{
            return NSArray()
        }else{
            let order = json.valueForKey("rent") as! NSArray
            return order
        }
    }

}