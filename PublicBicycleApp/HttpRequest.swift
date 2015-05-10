//
//  HttpRequest.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/10/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit
import SwiftHTTP


class HttpRequest{
    
    var baseURL: String = "http://10.20.46.218/PublicBicycleReservationSystem/APP/API/"
    var URL:String?
    var parameters: Dictionary<String, AnyObject>?
    var requestType:String?
    
    init(){
        URL = nil
        parameters = nil
        requestType = nil
    }
    
//    init(url: String, parameters: Dictionary<String, AnyObject>, requestType: String){
//        self.URL = url
//        self.parameters = parameters
//        self.requestType = requestType
//    }
    
    func doRequest() -> NSData?{
        var request = HTTPTask()
        
        var data: NSData?
        
        if self.requestType == "POST"{
            request.POST(self.baseURL + self.URL!,
                parameters: self.parameters,
                success: {(response:HTTPResponse) -> Void in
                    if response.responseObject != nil{
                        data = response.responseObject as! NSData
                        
//                        let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSDictionary
                        
                    }
                },failure:{(error:NSError,response: HTTPResponse?) -> Void in
                    println(error.description)
                    println(error.code)
            })
            
            return data
        }else if self.requestType == "GET"{
            request.GET(self.baseURL + self.URL!,
                parameters: self.parameters,
                success: {(response:HTTPResponse) -> Void in
                    if response.responseObject != nil{
                        data = response.responseObject as! NSData
                        
                    }
                },failure:{(error:NSError,response: HTTPResponse?) -> Void in
                    println(error.description)
                    println(error.code)
            })
            
            return data

        }else{
            return data;
        }
        
    }
    
    
    
    
}
