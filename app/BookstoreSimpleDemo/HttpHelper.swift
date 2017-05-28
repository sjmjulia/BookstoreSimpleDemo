//
//  HttpHelper.swift
//  BookstoreSimpleDemo
//
//  Created by ShenJiamei on 5/22/17.
//  Copyright © 2017 REINS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HttpHelper: NSObject {
    
    static let baseUrl:String = "http://192.168.1.102:8080/BookStore/rest/"
    static let getBooksUrl = baseUrl + "getBooks"
    static let deleteBookUrl = baseUrl + "deleteBook"
    static let updateBookUrl = baseUrl + "updateBook"
    static let addBookUrl = baseUrl + "addBook"

    
    /// send request without parameters with GET method
    ///
    /// - Parameters:
    ///   - strURL: strURL destination
    ///   - success: success to get response
    ///   - failure: fail to get response
    class func requestGETURL(_ strURL: String, success:@escaping ([String: Any]) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
//                print(resJson.stringValue)
                success(resJson.dictionaryObject!)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }

    
    /// send request with parameters with GET method
    ///
    /// - Parameters:
    ///   - strURL: destination url
    ///   - params: params []
    ///   - success: success to get response
    ///   - failure: fail to get response
    class func requestGETURL(_ strURL: String, params : [String : AnyObject]?, success:@escaping ([String : Any]) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL,parameters: params).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                //                print(resJson.stringValue)
                success(resJson.dictionaryObject!)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    /// send request with post method
    ///
    /// - Parameters:
    ///   - strURL: destination url
    ///   - params: params []
    ///   - headers: headers atttributes
    ///   - success: success to get response
    ///   - failure: fail to get response
    class func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, success:@escaping ([String: Any]) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (responseObject) -> Void in
            
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                //                print(resJson.stringValue)
                success(resJson.dictionaryObject!)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    /// send request with delete  method
    ///
    /// - Parameters:
    ///   - strURL: destination url
    ///   - params: params []
    ///   - headers: headers atttributes
    ///   - success: success to get response
    ///   - failure: fail to get response
    class func requestDELETEURL(_ strURL : String,params : String , success:@escaping ([String: Any]) -> Void, failure:@escaping (Error) -> Void){
        
        let uri = strURL + "/" + params
        
        Alamofire.request(uri, method: .get, encoding: JSONEncoding.default).responseJSON { (responseObject) -> Void in
            
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                //                print(resJson.stringValue)
                success(resJson.dictionaryObject!)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }

}
