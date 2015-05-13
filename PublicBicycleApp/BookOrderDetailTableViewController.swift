//
//  BookOrderDetailTableViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/12/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class BookOrderDetailTableViewController: BlueUITableViewController{
    
    var OrderDetail:NSDictionary?
    var orderType: String?
    
    @IBOutlet weak var OrderTitle: UILabel!
    @IBOutlet weak var OrderId: UILabel!

    @IBOutlet weak var CustomerId: UILabel!
    @IBOutlet weak var CustomerName: UILabel!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var leftTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if orderType == "Bike" {
            self.OrderTitle.text = "自行车预约订单"
            
            //get CustomerID
            let currentCustomerId = "emp.yangchunyu@gmail.com"
            
            self.OrderDetail = getUnfinishedBikeBookOrder(currentCustomerId)
        }else if orderType == "Parkingspace" {
            self.OrderTitle.text = "停车位预约订单"
            //get CustomerID
            let currentCustomerId = "emp.yangchunyu@gmail.com"
            
            self.OrderDetail = getUnfinishedParkingspaceBookOrder(currentCustomerId)
        }
        
        
        self.OrderId.text = OrderDetail?.valueForKey("id") as? String
        self.CustomerId.text = OrderDetail?.valueForKey("customer_id") as? String
        self.CustomerName.text = OrderDetail?.valueForKey("customer_name") as? String
        self.stationName.text = OrderDetail?.valueForKey("station_name") as? String
        self.startTime.text = OrderDetail?.valueForKey("start_time") as? String
        let left = OrderDetail?.valueForKey("left_time") as? Int
        self.leftTime.text = "\(left!)分钟"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func orderCancelDidClicked(sender: AnyObject) {
        
        if self.orderType == "Bike" {
            
            cancelBikeBookOrder(self.OrderDetail?.valueForKey("id") as! String)
            
        }else if self.orderType == "Parkingspace" {
            cancelParkingspaceBookOrder(self.OrderDetail?.valueForKey("id") as! String)
        }
        
    }
    
    func getUnfinishedBikeBookOrder(customerId: String)-> NSDictionary{
        var request = HttpRequest(url: "unfinishedOrder.php", parameters: ["tag": "bike", "customer_id": customerId])
        
        let json = request.getJsonDecode()
        let temp = json.valueForKey("bike") as! NSArray
        
        return temp[0] as! NSDictionary
    }
    
    func getUnfinishedParkingspaceBookOrder(customerId: String) ->NSDictionary{
        var request = HttpRequest(url: "unfinishedOrder.php", parameters: ["tag": "parkingspace", "customer_id": customerId])
        
        let json = request.getJsonDecode()
        let temp = json.valueForKey("parkingspace") as! NSArray
        return temp[0] as! NSDictionary
    }
    
    func cancelBikeBookOrder(orderId: String){
        var request = HttpRequest(url: "bikeBook.php", parameters: ["tag": "cancel", "UUID": orderId])
        var json = request.getJsonDecode()
        if json.valueForKey("error") as! Int == 1 {
            var alert : UIAlertView = UIAlertView(title: "该订单不存在", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else{
            var info: ReserveOrderViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ReserveOrderViewController") as! ReserveOrderViewController
            var alert : UIAlertView = UIAlertView(title: "取消订单成功", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    func cancelParkingspaceBookOrder(orderId: String){
        var request = HttpRequest(url: "parkingspaceBook.php", parameters: ["tag": "cancel", "UUID": orderId])
        var json = request.getJsonDecode()
        if json.valueForKey("error") as! Int == 1 {
            var alert : UIAlertView = UIAlertView(title: "该订单不存在", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else{
            var info: ReserveOrderViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ReserveOrderViewController") as! ReserveOrderViewController
            var alert : UIAlertView = UIAlertView(title: "取消订单成功", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }

    
}