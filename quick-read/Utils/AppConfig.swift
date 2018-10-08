//
//  AppConfig.swift
//  quick-read
//
//  AppConfig reads the app config properties file and creates variables for any keys you want
//  Created by Lawrence Edmondson on 10/2/18.
//  Copyright © 2018 Lawrence Edmondson. All rights reserved.
//
//

import UIKit

class AppConfig: NSObject {
    
    /**
         
      Config is a structure which represents the keys from a config file.
         
         - Throws: None
         
         - Returns: None explicity but creates the struct

    */
        
    struct Config: Decodable {
        private enum CodingKeys: String, CodingKey {
            case newsAPIKey
        }
        let newsAPIKey: String
    }

    /**
         
     Parses the config file
         
         - Throws: none but this should be wrapped in a proper try catch
         
         - Returns: none explicity but creates the struct
         
     */

    public func parseConfig() -> Config {
        let url = Bundle.main.url(forResource: "Config", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        
        //TODO: this should perform a guard or a proper try catch
        return try! decoder.decode(Config.self, from: data)
    }


}
