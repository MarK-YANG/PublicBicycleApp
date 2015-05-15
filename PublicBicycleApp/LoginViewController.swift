//
//  LoginViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/15/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class LoginViewController: BlueUIViewController {

    @IBOutlet weak var customerId: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeKeyBoard(){
        self.customerId.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    
    @IBAction func loginDidClicked(sender: AnyObject) {
        
        if customerId.text == "" || customerId.text == nil {
            var alert : UIAlertView = UIAlertView(title: "用户名不能为空", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else if password.text == "" || password.text == nil{
            var alert : UIAlertView = UIAlertView(title: "密码不能为空", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else{
            let request = HttpRequest(url: "LoginAndRegister.php", parameters: ["tag": "login", "customer_id": customerId.text, "password": password.text])
            let json = request.getJsonDecode()
            
            let errorMsg = json.valueForKey("error") as? Int
            
            if(errorMsg == 1){
                var alert : UIAlertView = UIAlertView(title: "用户名或密码不正确", message: nil, delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }else{
                var customerDefault = NSUserDefaults.standardUserDefaults()
                let customer = json.valueForKey("customer") as? NSDictionary
                let strCustomerId = customer?.valueForKey("customer_id") as? String
                let strCustomerName = customer?.valueForKey("name") as? String
                customerDefault.setObject(strCustomerId, forKey: "customer_id")
                customerDefault.setObject(strCustomerName, forKey: "customer_name")
                var info: UITabBarController = (self.storyboard?.instantiateViewControllerWithIdentifier("mainView") as? UITabBarController)!
                self.presentViewController(info, animated: true, completion: nil)
            }
        }

        
    }
    
    @IBAction func registerDidClicked(sender: AnyObject) {
    }
    
}
