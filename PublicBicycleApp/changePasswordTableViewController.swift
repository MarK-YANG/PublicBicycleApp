//
//  changePasswordTableViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/14/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class changePasswordTableViewController: BlueUITableViewController {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    
    var customerId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var user = NSUserDefaults.standardUserDefaults()
        customerId = user.objectForKey("customer_id") as? String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeDidClicked(sender: AnyObject) {
        
        if (oldPassword.text == "" || oldPassword.text == nil) {
            var alert : UIAlertView = UIAlertView(title: "原密码不能为空", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else if (newPassword.text == "" || newPassword.text == nil){
            var alert : UIAlertView = UIAlertView(title: "新密码不能为空", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else if (newPassword.text != rePassword.text){
            var alert : UIAlertView = UIAlertView(title: "两次输入的密码不相同", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else if ( count(newPassword.text) < 6 || count(newPassword.text) > 12){
            var alert : UIAlertView = UIAlertView(title: "密码应该至少6个且不超过12个字符", message: nil, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else{
            let error = changePassword(customerId!, oldPassword: self.oldPassword.text, newPassword: self.newPassword.text)
            
            if error == true{
                var alert : UIAlertView = UIAlertView(title: "修改成功，请牢记新密码", message: nil, delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                self.navigationController?.popToRootViewControllerAnimated(true)
            }else{
                var alert : UIAlertView = UIAlertView(title: "原密码不正确", message: nil, delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
        }
    }
    
    @IBAction func closeKeyBoard(){
        self.oldPassword.resignFirstResponder()
        self.newPassword.resignFirstResponder()
        self.rePassword.resignFirstResponder()
    }

    
    func changePassword(customerId: String, oldPassword: String, newPassword: String)->Bool{
        var request = HttpRequest(url: "customerAccount.php", parameters: ["tag": "changePassword", "customer_id": customerId, "old_password": oldPassword, "new_password": newPassword])
        
        let json = request.getJsonDecode()
        
        let errorMsg = json.valueForKey("error") as? Int
        
        if errorMsg == 0{
            return true;
        }else{
            return false;
        }
    }

}
