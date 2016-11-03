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
        DispatchQueue.global(qos: .default).async {
            Alamofire.request("https://api-public.guidebox.com/v1.43/US/\(kGuideBoxProductionAPIKey)/shows/all/\(offset)/20/all/all",
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: nil)
                .validate()
                .responseJSON { (response) -> Void in
                    if response.result.error != nil {
                        DispatchQueue.main.async {
                            fail(response.result.error! as NSError)
                            
                        }
                    }else {
                        //let jsonDict: NSDictionary = NSJSONSerialization.JSONObjectWithData(response.data, options: <#T##NSJSONReadingOptions#>)
                        let value: NSDictionary = response.result.value as! [String: AnyObject] as NSDictionary
                        let resultArray: NSArray = value.object(forKey: "results") as! [AnyObject] as NSArray
                        DispatchQueue.main.async {
                            success(resultArray)
                        }
                    }
            }
        }
        
    }
    
    // MARK: - TheMovieDB API
    
    func getShowInfoByID(id: NSString!, success: @escaping (_ result: NSDictionary) -> Void, fail: @escaping (_ error: NSError) -> Void) {
        DispatchQueue.global(priority: .default).async {
            let url = "\(kTheMovieDBBaseURL)\(kTVEndpoint)\(id)"
            Alamofire.request(url,
                              method: .get,
                              parameters: ["api_key": kTMDBApiKey],
                              encoding: URLEncoding.default,
                              headers: nil)
                .validate()
                .responseJSON { (response) -> Void in
                    if response.result.error != nil {
                        DispatchQueue.main.async {
                            fail(response.result.error! as NSError)
                        }
                    }else {
                        let value: NSDictionary = response.result.value as! [String: AnyObject] as NSDictionary
                        DispatchQueue.main.async {
                            success(value)
                        }
                    }
            }
        }
    }
}
