//
//  Post.swift
//  quick-read
//
//  Post is basically a class to encapsulate the structure of each news post
//  Created by Lawrence Edmondson on 10/2/18.
//  Copyright © 2018 Lawrence Edmondson. All rights reserved.
//
//

import UIKit
import IGListKit

class Post: ListDiffable {
    internal var id:Int
    internal var title:String
    internal var content:String
    internal var detail:String
    internal var source:String
    internal var image_url:String
    

    init (id:Int, title:String, content:String, detail: String, source: String, image_url:String) {
        self.id = id
        self.title = title
        self.content = content
        self.detail = detail
        self.source = source
        self.image_url = image_url
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? Post {
            return id == object.id
        }
        return false

    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
}
