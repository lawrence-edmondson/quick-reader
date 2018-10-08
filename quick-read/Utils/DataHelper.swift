//
//  DataHelper.swift
//  Notorious
//
//  Created by Lawrence Edmondson on 3/11/16.
//  Copyright © 2016 The Weekend SPIN. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


open class DataHelper {

    /**
     
      Handle a JSON response
         - Parameter url: the url for the request.
         - Parameter method: the http method which we want to use i.e. GET, POST.
         - Parameter headers: the http headers to be sent with the request.
         - Parameter parameters: is an array of parameters to be sent with the request.
         - Parameter completionHandler: is the completion handler for the callback
     
         - Throws: None
     
         - Returns: Upon success, the results are returned as a SwiftyJSON object.
                    Upon failure an error message is printed to the console.
     
    */
    func handleJSON(_ url: String?, _ method:HTTPMethod, _ headers: HTTPHeaders, _ parameters: Parameters?, completionHandler:@escaping (SwiftyJSON.JSON)-> Void) {
        let _ = Alamofire.SessionManager.default
        Alamofire.request(url!, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let dataSource = SwiftyJSON.JSON(value)
                    completionHandler(dataSource)
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
