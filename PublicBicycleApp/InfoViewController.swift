//
//  InfoViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/10/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//


import UIKit

class InfoViewController: BlueUITableViewController {

    @IBOutlet weak var UserName: UILabel!
    var customerName: String = "杨春雨"
    var customerId: String = "emp.yangchunyu@gmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getUserId And UserName
        
        UserName.text = self.customerName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutDidClicked(sender: AnyObject) {
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "getCustomerInfo" {
            var vc = segue.destinationViewController as! CustomerInfoTableViewController
            vc.customerInfo = getCustomerInfo(self.customerId)
        }
    }
    
    func getCustomerInfo(customerId: String)->NSDictionary{
        var request = HttpRequest(url: "customerAccount.php", parameters: ["tag": "get", "customer_id": customerId])
        var json = request.getJsonDecode() as NSDictionary
        if(json.valueForKey("error") as! Int == 0){
            return json.valueForKey("customer") as! NSDictionary
        }else{
            return NSDictionary()
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        
    }
}