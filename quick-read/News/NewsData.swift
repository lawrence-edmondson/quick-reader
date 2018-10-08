//
//  NewsData.swift
//  quick-read
//
// NewsData is reponsible for querying the data source and creating the data model
//  Created by Lawrence Edmondson on 10/2/18.
//  Copyright © 2018 Lawrence Edmondson. All rights reserved.
//

import UIKit
import Material
import Graph
import SwiftyJSON
import Alamofire
import IGListKit


class NewsData {
    //var tableViewDelegate: TableViewProtocol?

    
    public func getData(currentPage:Int, categories:[String], completion:@escaping(Bool)->Void) {
        let graph = Graph()
        graph.clear()
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter() //queue 1 begins
        for category in categories {
            let catNode = Entity(type: "Category")
            catNode["name"] = category
            getArticles(currentPage: currentPage, category: category) {(results) in
                let articles = results[0]["articles"].arrayValue
                for (c,article) in articles.enumerated() {
                    let item = Entity(type: "Article")
                    item["id"] = c as Int
                    item["title"] = article["title"].stringValue
                    item["detail"] = article["url"].stringValue
                    item["source"] = article["source"]["name"].stringValue
                    item["content"] = article["description"].stringValue
                    let imageUrl:String?
                    if article["image_url"].exists()  {
                        imageUrl = article["image_url"].stringValue
                    } else {
                        imageUrl = article["urlToImage"].stringValue
                    }
                    let regex = try! NSRegularExpression(pattern: "http:", options: NSRegularExpression.Options.caseInsensitive)
                    let range = NSMakeRange(0, (imageUrl?.characters.count)!)
                    let modImageUrl = regex.stringByReplacingMatches(in: imageUrl!, options: [], range: range, withTemplate: "https:")
                    item["image_url"] = modImageUrl
                    
                    item.is(relationship: "Post").in(object: catNode)
                    //dispatchGroup.leave() //queue 2 ends
                }
            } //getArticles
            
        } //categories
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            graph.async({ bool, error in
                if let error = error {
                    print("getData() Oops! Something went wrong trying to save the graph... \(error)")
                    completion(false)
                } else {
                    print("getData() Graphed saved")
                    completion(true)
                }
            })
            
        })
    }

    func getArticles(currentPage: Int, category:String, completion:@escaping([SwiftyJSON.JSON])->Void){
        let dataHelper = DataHelper()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/YYYY")
        let dateNow:Date = Date()
        let dateOffset = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -14, to: dateNow)!)
        var page = currentPage
        var pageSize = 100
        if (currentPage > 1) {
            pageSize = pageSize * currentPage
            page = 1
            
        }
        let appConfig = AppConfig()
        let config = appConfig.parseConfig()
        let apiKey = config.newsAPIKey
        
        let headers = ["X-Api-Key":apiKey]
        var url:String = ""
        var query:String = ""
        
        switch category {
        case "MUSIC":
            query += "\"hip hop\" OR music OR \"pop\" "

            url = "https://newsapi.org/v2/everything"
            url += "?q=\(query)"
            url += "&from=\(dateOffset)"
            url += "&sources=vice-news,mtv-news,"
            url += "&sortBy=publishedAt"
            //url += "&page=\(page)"
            //url += "&pageSize=\(pageSize)"

        case "CULTURE":
            query += "gossip OR hollywood OR entertainment"
            url = "https://newsapi.org/v2/everything"
            url += "?q=\(query)"
            url += "&from=\(dateOffset)"
            url += "&sources=entertainment-weekly,daily-mail"
            url += "&sortBy=publishedAt"
            //url += "&page=\(page)"
            //url += "&pageSize=\(pageSize)"
            
        case "TECH":
            query += "technology"
            url = "https://newsapi.org/v2/everything"
            url += "?q=\(query)"
            url += "&from=\(dateOffset)"
            url += "&sources=techcrunch,mashable"
            url += "&sortBy=publishedAt"
            //url += "&page=\(page)"
            //url += "&pageSize=\(pageSize)"

        default:
            return

        }
        
        let escapedUrl = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        dataHelper.handleJSON(escapedUrl, HTTPMethod.get, headers, nil, completionHandler: {(results:SwiftyJSON.JSON) ->Void in
            if let response:[SwiftyJSON.JSON] = [results] {
                completion(response)
            }
        })
    }
}
