//
//  ReserveOrderViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/11/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

protocol OrderStationViewDelegate{
    func getOrderInfo(_station: MyStation)
    
}

protocol OrderTypeViewDelegate{
    func getOrderType(_kind: Int)
}


class ReserveOrderViewController: UITableViewController, OrderStationViewDelegate, OrderTypeViewDelegate{
    
    
    @IBOutlet weak var StationName: UILabel!
    @IBOutlet weak var OrderType: UILabel!
    
    var currentStation: MyStation?
    var orderType: Int?
    var customerId: String?
    
    func getOrderInfo(_station: MyStation) {
        currentStation = _station
        StationName.text = _station.station_name
    }
    
    func getOrderType(_kind: Int){
        orderType = _kind
        if _kind == 0{
            OrderType.text = "预约自行车订单"
        }else{
            OrderType.text = "预约停车位订单"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController
        //RGB:30 144 255
        let mainColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        let navigationTitleAttribute : NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(),NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as [NSObject : AnyObject]

        var user = NSUserDefaults.standardUserDefaults()
        self.customerId = user.objectForKey("customer_id") as? String
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 0{
            var info:OrderStationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrderStationViewController") as! OrderStationViewController
            info.delegate = self
            self.navigationController?.pushViewController(info, animated: true)
        }else if indexPath.row == 1{
            var info: OrderTypeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrderTypeViewController") as! OrderTypeViewController
            info.delegate = self
            self.navigationController?.pushViewController(info, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonDidClicked(sender: AnyObject) {
        
        if currentStation == nil {
            var alert : UIAlertView = UIAlertView(title: "请选择一个服务站", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else if orderType == nil{
            var alert : UIAlertView = UIAlertView(title: "请选择订单类型", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else{
            if orderType == 0{
                
                //request to the web server
                var customerId = "emp.yangchunyu@gmail.com"
                var response = createBikeBookOrder(self.customerId!, stationId: currentStation!.station_id) as NSDictionary
                
                if(response.valueForKey("error") as! Int == 1){
                    
                    //add order failed
                    
                    if(response.valueForKey("error_msg") as! String == "cannot create another order with a unfinished order !"){
                        
                        //there is an unfinished order
                        var alert : UIAlertView = UIAlertView(title: "不可以同时创建两个预约订单，请先完成未完成的预约订单", message: nil, delegate: nil, cancelButtonTitle: "确定")
                        alert.show()
                    }else if (response.valueForKey("error_msg") as! String == "There is no available bikes at this station!"){
                        
                        //there is no available bikes
                        var alert : UIAlertView = UIAlertView(title: "该服务站没有可预约的自行车，请选择其他服务站", message: nil, delegate: nil, cancelButtonTitle: "确定")
                        alert.show()
                    }
                }else{
                    //add order success
                    var bikeOrderInfo = response.valueForKey("order") as! NSDictionary
                    var info: AddBookOrderSuccess = self.storyboard?.instantiateViewControllerWithIdentifier("AddBookOrderSuccess") as! AddBookOrderSuccess
                    info.orderInfoDic = bikeOrderInfo
                    info.orderType = "BikeBook"
                    self.navigationController?.pushViewController(info, animated: true)
                    
                }
                
            }else if orderType == 1{
                //request to the web server
                var response = createParkingspaceBookOrder(self.customerId!, stationId: currentStation!.station_id) as NSDictionary
                
                if(response.valueForKey("error") as! Int == 1){
                    //add order failed
                    
                    if(response.valueForKey("error_msg") as! String == "cannot create another order with a unfinished order !" ){
                        //there is an unfinished order
                        var alert : UIAlertView = UIAlertView(title: "不可以同时创建两个预约订单，请先完成未完成的预约订单", message: nil, delegate: nil, cancelButtonTitle: "确定")
                        alert.show()
                    }else if (response.valueForKey("error_msg") as! String == "There is no available bikes at this station!"){
                        
                        //there is no available parkingspace
                        var alert : UIAlertView = UIAlertView(title: "该服务站没有可预约的自行车停车位，请选择其他服务站", message: nil, delegate: nil, cancelButtonTitle: "确定")
                        alert.show()
                    }
                }else{
                    //add order success
                    var parkingspaceOrderInfo = response.valueForKey("order") as! NSDictionary

                    var info: AddBookOrderSuccess = self.storyboard?.instantiateViewControllerWithIdentifier("AddBookOrderSuccess") as! AddBookOrderSuccess
                    info.orderInfoDic = parkingspaceOrderInfo
                    info.orderType = "ParkingspaceBook"
                    self.navigationController?.pushViewController(info, animated: true)
                }
            }
        }

    }
    
    func createBikeBookOrder(customerId: String, stationId: String)-> NSDictionary{
        var request = HttpRequest(url: "bikeBook.php", parameters: ["tag": "add", "customer_id": customerId, "station_id": stationId])
        
        var json = request.getJsonDecode()
        
        return json
    }
    
    func createParkingspaceBookOrder(customerId: String, stationId: String)->NSDictionary{
        
        var request = HttpRequest(url: "parkingspaceBook.php", parameters: ["tag": "add", "customer_id": customerId, "station_id": stationId])
        
        var json = request.getJsonDecode()
        
        return json

    }
}
