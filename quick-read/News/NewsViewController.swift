//
//  NewsViewController.swift
//  quick-read
//
//  NewsViewController is essentially our main View Controller
//  Created by Lawrence Edmondson on 10/2/18.
//  Copyright © 2018 Lawrence Edmondson. All rights reserved.
//
//

import UIKit
import IGListKit
import Material
import Graph


class NewsViewCollectionController: UIViewController, ListAdapterDataSource {

    
    internal var category: String
    internal var graph: Graph!
    internal var search: Search<Entity>!

    var loader: UIActivityIndicatorView? = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorView.Style.gray)
    let greyBG:UIColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    var detailUrl:String?
    fileprivate var fabButton: FABButton!
    let dispatchGroup = DispatchGroup()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 2)
    }()

    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    required init?(coder aDecoder: NSCoder) {
        category = ""
        super.init(coder: aDecoder)
        prepareTabItem()
    }
    
    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
        prepareTabItem()
    }

    

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        
        // Model.
        //prepareGraph()
       //prepareSearch()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    //MARK : Instagram
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        prepareGraph()
        prepareSearch()
        var data: [Entity] {
            guard let category = search.sync().first else {
            return [Entity]()
        }
            
            dispatchGroup.enter()
            let posts = category.relationship(types: "Post").subject(types: "Article")
            dispatchGroup.leave()
            return posts.sorted { (a, b) -> Bool in
                //print("PostsViewController() posts \(posts)")
                return a.createdDate < b.createdDate
            }
        }
        
        var postList:[Post] = []
        for post in data {
            let postItem = Post(id: post["id"] as! Int,
                             title: post["title"] as! String,
                             content: post["content"] as! String,
                             detail: post["detail"] as! String,
                             source: post["source"] as! String,
                             image_url: post["image_url"] as! String)
            
            //print("title \(post["title"]) ")
            postList.append(postItem)
        }
        return postList as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return NewsCollectionView()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    

}


//MARK : Material

extension NewsViewCollectionController {
    internal func prepareGraph() {
        graph = Graph()
    }
    
    internal func prepareSearch() {
        search = Search<Entity>(graph: graph).for(types: "Category").where(properties: ("name", category))
    }
}

extension NewsViewCollectionController {
    
    internal func prepareTabItem() {
   
        let defaultAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(name: "Raleway-ExtraBold", size: 11)!,
                                                                     NSAttributedString.Key.foregroundColor: UIColor.gray,
                                                                     (NSAttributedString.Key.kern as NSString) as NSAttributedString.Key:3.5 as AnyObject]
        
        let selectedAttributes:[NSAttributedString.Key:AnyObject] =  [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(name: "Raleway-ExtraBold", size: 11)!,
                                                                      NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                     (NSAttributedString.Key.kern as NSString) as NSAttributedString.Key:3.5 as AnyObject]
 
        let defaultTabTitle : NSAttributedString = NSAttributedString(string: category, attributes: defaultAttributes)
        let selectedTabTitle : NSAttributedString = NSAttributedString(string: category, attributes: selectedAttributes)
        tabItem.setAttributedTitle(selectedTabTitle, for: .highlighted)
        tabItem.setAttributedTitle(defaultTabTitle, for: .normal)
        
    }
    

}



