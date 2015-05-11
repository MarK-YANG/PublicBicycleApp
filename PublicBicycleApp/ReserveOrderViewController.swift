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
        //tabBarController
        //self.tabBarController?.tabBar.barTintColor = mainColor
        //self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        
        
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
        println(currentStation?.station_id)
        println("\(orderType)")
    }
}
