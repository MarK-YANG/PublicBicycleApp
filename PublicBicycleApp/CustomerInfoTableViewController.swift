//
//  CustomerInfoTableViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/14/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class CustomerInfoTableViewController: BlueUITableViewController {

    @IBOutlet weak var customerId: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var citizenId: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var breakCounts: UILabel!
    @IBOutlet weak var customerLevel: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    var customerInfo: NSDictionary?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customerId.text = customerInfo?.valueForKey("customer_id") as? String
        self.customerName.text = customerInfo?.valueForKey("name") as? String
        let iGender = customerInfo?.valueForKey("gender") as? Int
        
        if iGender == 1{
             self.gender.text = "男"
        }else if iGender == 0{
             self.gender.text = "女"
        }
        
        self.birthDate.text = customerInfo?.valueForKey("birthdate") as? String
        let strCitzenId = customerInfo?.valueForKey("citizen_id") as? NSString
        self.citizenId.text = strCitzenId!.substringToIndex(6) + "********" + strCitzenId!.substringFromIndex(14)
        self.createTime.text = customerInfo?.valueForKey("create_time") as? String
        let strBreakCount = customerInfo?.valueForKey("break_count") as? String
        self.breakCounts.text = strBreakCount! + " 次"
        let strCustomerLevel = customerInfo?.valueForKey("level") as? String
        self.customerLevel.text = "LEVEL " + strCustomerLevel!
        self.balance.text = (customerInfo?.valueForKey("balance") as? String)! + " 元"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
