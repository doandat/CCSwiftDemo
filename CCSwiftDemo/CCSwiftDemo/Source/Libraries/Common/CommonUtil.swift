//
//  CommonUtil.swift
//  BaseProjectSwift
//
//  Created by DatDV on 1/6/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation
import Alamofire

struct CommonUtil
{
    static func getDisplayNameApp() -> String
    {
        return "Base Project"
    }
    
    static func convertToDictionary(text: String?) -> [String: Any]?
    {
        guard let textToConvert = text else {
            return nil;
        }
        
        if let data = textToConvert.data(using: .utf8)
        {
            do
            {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func isCallAPISuccess(result: Result<Any>) -> Bool
    {
        if result.isFailure
        {
            return false
        }
        
        return true
    }
    
    static func isNeedRefreshToken(result: Result<Any>) -> Bool
    {
        return false
    }
    
    static func isCallAPIErrorNotDetermine(result: Result<Any>) -> Bool
    {
        return (result.value == nil)
    }
    
    
    
}

