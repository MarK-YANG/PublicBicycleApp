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
    var customerName: String = ""
    var customerId: String = "emp.yangchunyu@gmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getUserId And UserName
        var user = NSUserDefaults.standardUserDefaults()
        customerName = user.objectForKey("customer_name") as! String
        customerId = user.objectForKey("customer_id") as! String
        
        UserName.text = self.customerName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutDidClicked(sender: AnyObject) {
        
        var alertController = UIAlertController(title: "退出登录？", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        self.presentViewController(alertController, animated: true, completion: nil)
        var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        var deleteAction = UIAlertAction(title: "退出", style: UIAlertActionStyle.Destructive) { (UIAlertAction) -> Void in
            let customerDefault = NSUserDefaults.standardUserDefaults()
            customerDefault.setObject("", forKey: "customer_id")
            customerDefault.setObject("", forKey: "customer_name")
            var info: LoginViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController)!
            self.presentViewController(info, animated: true, completion: nil)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)

        
//        let customerDefault = NSUserDefaults.standardUserDefaults()
//        customerDefault.setObject("", forKey: "customer_id")
//        customerDefault.setObject("", forKey: "customer_name")
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
    
}