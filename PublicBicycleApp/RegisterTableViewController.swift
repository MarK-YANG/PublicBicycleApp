//
//  RegisterTableViewController.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/15/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit

class RegisterTableViewController: BlueUITableViewController {

    @IBOutlet weak var customerId: UITextField!
    @IBOutlet weak var customerName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    @IBOutlet weak var citizenId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.backgroundColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeKeyBoard(){
        self.customerId.resignFirstResponder()
        self.password.resignFirstResponder()
        self.customerName.resignFirstResponder()
        self.rePassword.resignFirstResponder()
        self.citizenId.resignFirstResponder()
    }
    
    @IBAction func registerDidClicked(sender: AnyObject) {
        
        if customerId.text == "" || customerId.text == nil{
            var alert : UIAlertView = UIAlertView(title: "帐户名称不能为空", message: "应该为有效的邮箱格式", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else if customerName.text == "" || customerName.text == nil{
            var alert : UIAlertView = UIAlertView(title: "客户姓名不能为空", message: "应该为客户的真实性名", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else if password.text == "" || password.text == nil{
            var alert : UIAlertView = UIAlertView(title: "密码不能为空", message: "密码应为长度6——12字符", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else if citizenId.text == "" || citizenId.text == nil{
            var alert : UIAlertView = UIAlertView(title: "身份证号码不能为空", message: "密码有效的身份证号码", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }else{
            if password.text != rePassword.text {
                var alert : UIAlertView = UIAlertView(title: "两次输入的密码不一致", message: "请重新输入", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }else if !validatePassword(password.text) {
                var alert : UIAlertView = UIAlertView(title: "请输入有效的密码格式", message: "密码应为长度6——12字符", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }else if !validateCustomerId(customerId.text) {
                
                var alert : UIAlertView = UIAlertView(title: "请输入有效帐户名称", message: "帐户名称应为有效的邮箱格式", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            
            }else if !validateCitizenId(citizenId.text){
                var alert : UIAlertView = UIAlertView(title: "请输入有效的18位公民身份证号码", message: "请重新输入", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }else{
               let request = HttpRequest(url: "LoginAndRegister.php", parameters: [
                    "tag": "register",
                    "customer_id": customerId.text,
                    "citizen_id": citizenId.text,
                    "gender": getGenderFromCitizenId(citizenId.text),
                    "name": customerName.text,
                    "birthdate": getBirthDateFromCitizenId(citizenId.text),
                    "password": password.text
                ])
                
                let json = request.getJsonDecode()
                
                let errorMsg = json.valueForKey("error") as? Int
                if errorMsg == 1{
                    //customer already exsist
                    var alert : UIAlertView = UIAlertView(title: "用户名已存在", message: "请直接登录", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                }else{
                    //register success got main board
                    let customerDefault = NSUserDefaults.standardUserDefaults()
                    customerDefault.setObject(customerId.text, forKey: "customer_id")
                    customerDefault.setObject(customerName.text, forKey: "customer_name")
                    var info: UITabBarController = (self.storyboard?.instantiateViewControllerWithIdentifier("mainView") as? UITabBarController)!
                    self.presentViewController(info, animated: true, completion: nil)
                }
            }
        }
    }
    
    func validatePassword(passwd: String)-> Bool{
        if count(passwd) > 12 || count(passwd) < 6{
            return false
        }else{
            return true
        }
    }

    func validateCustomerId(id: String)-> Bool{
        //swift regular expression validate falied

//        let emailFormat = "/^([0-9A-Za-z\\-_\\.]+)@([0-9a-z]+\\.[a-z]{2,3}(\\.[a-z]{2})?)$/i"
//        var regexTestEmail = NSPredicate(format: "SELF MATCHES %@",emailFormat)
//        
//        if regexTestEmail.evaluateWithObject(id) == true {
//            println("success")
//            return true
//        }else{
//            return false
//        }
        
        //validate by the server
        let request = HttpRequest(url: "LoginAndRegister.php", parameters: ["tag": "validate", "email": id])
        let json = request.getJsonDecode()
        let error = json.valueForKey("error") as? Int
        if error == 0{
            return true
        }else{
            return false
        }
    }
    
    func getBirthDateFromCitizenId(citizenId: String)-> String{
        let year = (citizenId as NSString).substringWithRange(NSMakeRange(6, 4))
        let month = (citizenId as NSString).substringWithRange(NSMakeRange(10, 2))
        let day = (citizenId as NSString).substringWithRange(NSMakeRange(12, 2))
        let birthDate = year + "-" + month + "-" + day
        return birthDate
    }
    
    func getGenderFromCitizenId(citizenId: String)-> String{
        return "\((citizenId as NSString).substringWithRange(NSMakeRange(16, 1)).toInt()! % 2)"
    }

    func validateCitizenId(citizenId: String)-> Bool{
       
        if count(citizenId) != 18 {
            return false
        }else{
            
            var eachElement = [String]()
            
            for var i = 0; i < count(citizenId); ++i{
                var temp = (citizenId as NSString).substringWithRange(NSMakeRange(i, 1))
                eachElement.append(temp)
            }
            
            let weight = [7, 9, 10, 5, 8 , 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
            
            let parity_bit = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"]
            
            var sum = 0
            
            for var i = 0; i < 17; ++i {
                var iEle = eachElement[i].toInt()
                sum += weight[i] * iEle!
            }
            
            let result_count = sum % 11
            
            let result_parity_bit = parity_bit[result_count]
            
            if result_parity_bit == eachElement[17] {
                return true
            }else{
                return false
            }
        }
        
        
    }
    
    func isTelNumber(num:NSString)->Bool
    {
        var mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        var  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        var  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        var  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        var regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        var regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        var regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        var regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluateWithObject(num) == true)
            || (regextestcm.evaluateWithObject(num)  == true)
            || (regextestct.evaluateWithObject(num) == true)
            || (regextestcu.evaluateWithObject(num) == true))
        {
            return true
        }
        else
        {
            return false
        }
        
        
        
    }
    
}
