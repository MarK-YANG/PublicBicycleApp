//
//  StationInfoViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/11/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class StationInfoViewController: UITableViewController {

    @IBOutlet weak var station_name: UILabel!
    @IBOutlet weak var station_address: UILabel!
    @IBOutlet weak var station_phone_num: UILabel!
    
    var station:MyStation?
    
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
        
        if station == nil {
            station_name.text = ""
            station_address.text = ""
            station_phone_num.text = ""
        }else{
            station_name.text = station?.station_name
            
            station_address.text = station?.station_address
            station_address.numberOfLines = 2
            station_phone_num.text = station?.station_phone_num
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}