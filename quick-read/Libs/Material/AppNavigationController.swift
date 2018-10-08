//
//  AppNavigationController.swift
//  spin
//
//  Created by Lawrence Edmondson on 6/23/18.
//  Copyright © 2018 Eat Big Digital LLC. All rights reserved.
//

import UIKit
import Material

class AppNavigationController: NavigationController {
    let greyBG:UIColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)

    open override func prepare() {
        super.prepare()
        isMotionEnabled = true
        
        guard let nav = navigationBar as? NavigationBar else {
            return
        }
        
        nav.depthPreset = .none
        nav.dividerColor = Color.grey.lighten2
        nav.isHidden = true
        nav.barStyle = UIBarStyle.black
        nav.barTintColor = self.greyBG
        nav.tintColor = UIColor.white
    }
    
    public func initNavBar(_ title:String, controller:UIViewController, nav:NavigationBar) {
        let greyBG:UIColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        nav.barStyle = UIBarStyle.black
        nav.barTintColor = greyBG
        let colour = UIColor.white
        let attributes:[NSAttributedString.Key:AnyObject] =  [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont.systemFont(ofSize: 11),
                                                             NSAttributedString.Key.foregroundColor: colour,
                                                             (NSAttributedString.Key.kern as NSString) as NSAttributedString.Key:3.5 as AnyObject]
        let controllerTitle : NSAttributedString = NSAttributedString(string: title, attributes: attributes)
        let titleLabel = UILabel()
        titleLabel.attributedText = controllerTitle
        titleLabel.sizeToFit()
        controller.navigationItem.titleView = titleLabel
        controller.navigationItem.titleView = titleLabel
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: UIControl.State.normal)
    }

}
