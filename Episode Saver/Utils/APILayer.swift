//
//  APILayer.swift
//  Episode Saver
//
//  Created by Denis on 7/19/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation
import Alamofire

class APILayer: NSObject {
    static let sharedInstance = APILayer()
    private override init() {}
    
    func getTVShowsList(offset offset: NSString, success: (result: NSArray) -> Void, fail: (error: NSError) -> Void) {
        Alamofire.request(.GET,
                          "https://api-public.guidebox.com/v1.43/US/JMjLR7KJH7DJiDCMoUxvsf4xjLHnLW/shows/all/\(offset)/100/all/all",
                          parameters: nil,
                          encoding: .URL,
            headers: nil)
            .validate()
            .responseJSON { (response) -> Void in
                if response.result.error != nil {
                    fail(error: response.result.error!)
                }else {
                    //let jsonDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(response.data, options: <#T##NSJSONReadingOptions#>)
                    let value: NSDictionary = response.result.value as! [String: AnyObject]
                    let resultArray: NSArray = value.objectForKey("results") as! [AnyObject]
                    
                    success(result: resultArray)
                }
        }
        
    }
    
    // MARK: - TheMovieDB API
    
    func getShowInfoByID(id id: NSString!, success: (result: NSDictionary) -> Void, fail: (error: NSError) -> Void) {
        let url = "\(kTheMovieDBBaseURL)\(kTVEndpoint)\(id)"
        Alamofire.request(.GET,
            url,
            parameters: ["api_key": kTMDBApiKey],
            encoding: .URL,
            headers: nil)
            .validate()
            .responseJSON { (response) -> Void in
                if response.result.error != nil {
                    fail(error: response.result.error!)
                }else {
                    let value: NSDictionary = response.result.value as! [String: AnyObject]
                    success(result: value)
                }
        }
    }
}
