//
//  OrderViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/10/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//


import UIKit

class OrderViewController: BlueUITableViewController, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if indexPath.row == 0{
            
            //getCustomerId
            let customerId = "emp.yangchunyu@gmail.com"
            
            var result = getUnfinishedBikeBookOrder(customerId)
            if(result.count == 0){
                //dont have book order
                
                var alert : UIAlertView = UIAlertView(title: "没有未完成预约订单，欢迎使用本系统", message: nil, delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }else{
                //gotoBookOrderDetail
                var info: BookOrderDetailTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("BookOrderDetailTableViewController") as! BookOrderDetailTableViewController
                info.orderType = "Bike"
                self.navigationController?.pushViewController(info, animated: true)
            }

            
        }else if indexPath.row == 1{
            //getCustomerId
            let customerId = "emp.yangchunyu@gmail.com"
            
            var result = getUnfinishedParkingspaceBookOrder(customerId)
            if(result.count == 0){
                //dont have book order
                
                var alert : UIAlertView = UIAlertView(title: "没有未完成预约订单，欢迎使用本系统", message: nil, delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }else{
                //gotoParkingspaceOrderDetail
                var info: BookOrderDetailTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("BookOrderDetailTableViewController") as! BookOrderDetailTableViewController
                info.orderType = "Parkingspace"
                self.navigationController?.pushViewController(info, animated: true)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "historicalBikeBookOrder"{
            var vc = segue.destinationViewController as! OrderListTableViewController
            vc.OrderType = 2
        }else if segue.identifier == "historicalParkingspaceBookOrder"{
            var vc = segue.destinationViewController as! OrderListTableViewController
            vc.OrderType = 3
        }else if segue.identifier == "historicalRentOrder"{
            var vc = segue.destinationViewController as! OrderListTableViewController
            vc.OrderType = 4
        }
    
    }
    
    
    func getUnfinishedBikeBookOrder(customerId: String)-> NSArray{
        var request = HttpRequest(url: "unfinishedOrder.php", parameters: ["tag": "bike", "customer_id": customerId])
        
        let json = request.getJsonDecode()
        let error = json.valueForKey("error") as! Int
        
        if error == 1{
            return NSArray()
        }else{
            return json.valueForKey("bike") as! NSArray
        }
    }
    
    func getUnfinishedParkingspaceBookOrder(customerId: String) ->NSArray{
        var request = HttpRequest(url: "unfinishedOrder.php", parameters: ["tag": "parkingspace", "customer_id": customerId])
        
        let json = request.getJsonDecode()
        let error = json.valueForKey("error") as! Int
        
        if error == 1{
            return NSArray()
        }else{
            return json.valueForKey("parkingspace") as! NSArray
        }
    }

}