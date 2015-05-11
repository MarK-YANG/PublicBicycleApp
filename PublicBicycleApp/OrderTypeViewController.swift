//
//  OrderTypeViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/11/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class OrderTypeViewController: UITableViewController, UITableViewDelegate {
    
    var delegate : OrderTypeViewDelegate!
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.delegate.getOrderType(indexPath.row)
        println("\(indexPath.row)")
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
