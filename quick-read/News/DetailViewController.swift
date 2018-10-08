//
//  DetailViewController.swift
//  quick-read
//
//  DetailViewController is reponsible for rendering the detail view of a given link
//  Created by Lawrence Edmondson on 10/2/18.
//  Copyright © 2018 Lawrence Edmondson. All rights reserved.
//
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    var detailUrl: String!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    let greyBG:UIColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    let dispatchGroup = DispatchGroup()
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        dispatchGroup.enter()
        //webviewview
        //let url = URL(string: self.detailUrl)!
        webView.load(URLRequest(url: URL(string: self.detailUrl)! ))
        dispatchGroup.leave()
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            self.loader?.stopAnimating()
        })


        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loader?.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loader?.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loader?.stopAnimating()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
