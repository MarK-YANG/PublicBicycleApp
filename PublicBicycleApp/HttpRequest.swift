//
//  HttpRequest.swift
//  PublicBicycleApp
//
//  Created by MarK on 5/10/15.
//  Copyright (c) 2015 MarK. All rights reserved.
//

import UIKit
import SwiftHTTP


class HttpRequest: NSObject{
    
    let baseURL: String = "http://180.161.177.183/PublicBicycleReservationSystem/APP/API/"
    var URL:String
    var parameters: Dictionary<String, AnyObject>
    var jsonCode = NSDictionary()
    var requestStates = false
    
    override init(){
        self.URL = ""
        self.parameters = ["EMPTY":"EMPTY"]
    }
    
    init(url: String, parameters: Dictionary<String, AnyObject>){
        self.URL = url
        self.parameters = parameters
    }
    
    func print(){
        println(self.baseURL + self.URL)
        println(self.parameters)
    }
    
    func doPOST(){
        var request = HTTPTask()
        
        request.POST(self.baseURL + self.URL,
            parameters: self.parameters,
            success: {(response:HTTPResponse) in
                if response.responseObject != nil{
                    
                    let data = response.responseObject as! NSData
                    let json = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSDictionary)!
                    self.jsonCode = json
                    self.requestStates = true
                    
                }
            },failure:{(error:NSError,response: HTTPResponse?) in
                println(error.description)
                println(error.code)
                
        })

    }
    
    func doGET(){
        var request = HTTPTask()
        
        request.GET(self.baseURL + self.URL,
            parameters: self.parameters,
            success: {(response:HTTPResponse) -> Void in
                if response.responseObject != nil{
                    let data = response.responseObject as! NSData
                    var result = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSDictionary)!
                    
                }
            },failure:{(error:NSError,response: HTTPResponse?) -> Void in
                println(error.description)
                println(error.code)
        })

    }
    
    func getJsonDecode()-> NSDictionary{
        doPOST()
        while true{
            if self.requestStates{
                break
            }
        }
        return self.jsonCode
    }
    
}
