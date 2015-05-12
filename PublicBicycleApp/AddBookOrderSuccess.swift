//
//  AddBookOrderSuccess.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/12/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//


import UIKit

class AddBookOrderSuccess: UITableViewController {
    
    var orderInfoDic: NSDictionary?
    var orderType: String?

    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var customerId: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var createTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController
        //RGB:30 144 255
        let mainColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        

        let navigationTitleAttribute : NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(),NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as [NSObject : AnyObject]
       
        orderId.text = orderInfoDic?.valueForKey("id") as? String
        customerId.text = orderInfoDic?.valueForKey("customer_id") as? String
        customerName.text = orderInfoDic?.valueForKey("customer_name") as? String
        stationName.text = orderInfoDic?.valueForKey("station_name") as? String
        createTime.text = orderInfoDic?.valueForKey("start_time") as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func orderCancelDidClicked(sender: AnyObject) {
        if self.orderType == "BikeBook" {
            
            cancelBikeBookOrder((self.orderInfoDic?.valueForKey("id") as? String)!)
            
        }else if self.orderType == "ParkingspaceBook" {
            
        }
        
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


}