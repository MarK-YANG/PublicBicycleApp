//
//  ViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/10/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit
import SwiftHTTP
protocol OrderStationDelegate{
    func getValue(station:MyStation)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController
        //RGB:30 144 255
        let mainColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        

        let navigationTitleAttribute : NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(),NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as [NSObject : AnyObject]

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 0{
//            var info :OrderStationViewController = OrderStationViewController()
//            self.navigationController?.pushViewController(info, animated: false)
            var info:OrderStationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrderStationViewController") as! OrderStationViewController
            self.navigationController?.pushViewController(info, animated: true)
            
            println("\(indexPath.row)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell : UITableViewCell
        
        if indexPath.row == 0{
            cell = self.tableView.dequeueReusableCellWithIdentifier("ReserveTableCell1") as! UITableViewCell
        }else if indexPath.row == 1{
            cell = self.tableView.dequeueReusableCellWithIdentifier("ReserveTableCell2") as! UITableViewCell
        }else if indexPath.row == 2{
            cell = self.tableView.dequeueReusableCellWithIdentifier("ReserveTableCell3") as! UITableViewCell
        }else{
            cell = self.tableView.dequeueReusableCellWithIdentifier("ReserveTableCell1") as! UITableViewCell
        }
        
        return cell
    }
    
    
}

