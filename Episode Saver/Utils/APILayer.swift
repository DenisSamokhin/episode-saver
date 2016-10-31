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
    fileprivate override init() {}
    
    func getTVShowsList(offset: NSString, success: @escaping (_ result: NSArray) -> Void, fail: @escaping (_ error: NSError) -> Void) {
        dispatch_get_global_queue(DispatchQueue.GlobalQueuePriority.default, 0).async {
            Alamofire.request(.GET,
                "https://api-public.guidebox.com/v1.43/US/\(kGuideBoxProductionAPIKey)/shows/all/\(offset)/20/all/all",
                parameters: nil,
                encoding: .URL,
                headers: nil)
                .validate()
                .responseJSON { (response) -> Void in
                    if response.result.error != nil {
                        dispatch_async(dispatch_get_main_queue()) {
                            fail(error: response.result.error!)
                        }
                    }else {
                        //let jsonDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(response.data, options: <#T##NSJSONReadingOptions#>)
                        let value: NSDictionary = response.result.value as! [String: AnyObject]
                        let resultArray: NSArray = value.objectForKey("results") as! [AnyObject]
                        dispatch_async(dispatch_get_main_queue()) {
                            success(result: resultArray)
                        }
                    }
            }
        }
        
    }
    
    // MARK: - TheMovieDB API
    
    func getShowInfoByID(id: NSString!, success: @escaping (_ result: NSDictionary) -> Void, fail: @escaping (_ error: NSError) -> Void) {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            let url = "\(kTheMovieDBBaseURL)\(kTVEndpoint)\(id)"
            Alamofire.request(.GET,
                url,
                parameters: ["api_key": kTMDBApiKey],
                encoding: .URL,
                headers: nil)
                .validate()
                .responseJSON { (response) -> Void in
                    if response.result.error != nil {
                        dispatch_async(dispatch_get_main_queue()) {
                            fail(error: response.result.error!)
                        }
                    }else {
                        let value: NSDictionary = response.result.value as! [String: AnyObject]
                        dispatch_async(dispatch_get_main_queue()) {
                            success(result: value)
                        }
                    }
            }
        }
    }
}
