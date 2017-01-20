//
//  APIClient.swift
//  BaseProjectSwift
//
//  Created by DatDV on 1/9/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation
import Alamofire

enum WSRequestToken: Int
{
    case WSRequestTokenNone
    case WSRequestTokenRequire
}

enum WSRequestResult: Int
{
    case WSRequestResultSuccess
    case WSRequestResultServerErr
    case WSRequestResultNetworkErr
    case WSRequestResultTimeOut
    case WSRequestResultTokenInvalid
    case WSRequestResultWrongParam
}



class AccessTokenAdapter: RequestAdapter {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        
        
        return urlRequest
    }
}

typealias NetworkOperationCompletionHandler = (_ responseObject: Result<Any>?, _ error: Error?) -> ()


class APIClient: SessionManager
{
    let baseURLString = "http://anvietcomputer.com/api/"
    
//    let baseURLString = "http://tookyo.xyz/wp-json/wp/v2/"

    weak var request: Alamofire.Request?

    static let sharedInstance: APIClient = APIClient()

    private init()
    {
        super.init()
        
        self.session.configuration.timeoutIntervalForRequest = TimeInterval(timeoutForRequest)
        
    }

    
//    let networkOperationCompletionHandler: (_ responseObject: Any?, _ error: Error?) -> ()
    
    // we'll also keep track of the resulting request operation in case we need to cancel it later
    

    func addToken(tokenType: WSRequestToken)
    {
        if tokenType == WSRequestToken.WSRequestTokenNone
        {
            self.adapter = AccessTokenAdapter(accessToken: self.token())

        }
    }
    
    fileprivate func token() -> String
    {
        return "token?"
    }
    

    func cancel()
    {
        request?.cancel()
        
    }
    
    
    // MARK: Private func GET
    fileprivate func GET(path: String, completion: @escaping NetworkOperationCompletionHandler)
    {
        let urlRequest = baseURLString + path
        
        guard let safeURL = urlRequest.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        
        
        request = self.request(safeURL, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON {
                [weak self] response in
                
//                guard let strongSelf = self else { return }
                
                if let url = response.request?.urlRequest?.url?.absoluteString
                {
                    print("url:\(url)")
                }

                
                if response.result.isFailure
                {
                    print("failure")
                }
                
                completion(response.result, response.result.error)
                
        }
    }
    
    fileprivate func POST(path: String, parameters:[String: String]?, completion: @escaping NetworkOperationCompletionHandler)
    {
        let urlRequest = baseURLString + path
        
        guard let safeURL = urlRequest.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        
        
        request = self.request(safeURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON {
                [weak self] response in
                
//                guard let strongSelf = self else { return }
                
                if let url = response.request?.urlRequest?.url?.absoluteString
                {
                    print("url:\(url)")
                }
                
                
                if response.result.isFailure
                {
                    print("failure")
                }
                
                completion(response.result, response.result.error)
                
        }
    }
    
}


extension APIClient
{
    func getLocationUser(completion: @escaping NetworkOperationCompletionHandler)
    {
        self.GET(path: "login?username=1&password=c4ca4238a0b923820dcc509a6f75849b", completion: completion)
    }
    
    func createUser(device_token: String, device_id: String, completion: @escaping NetworkOperationCompletionHandler)
    {
        let parameters = ["device_token": "2kdjlskjd", "device_id" : "21"]
        
        self.POST(path: "users/create", parameters: parameters, completion: completion)
    }
}




