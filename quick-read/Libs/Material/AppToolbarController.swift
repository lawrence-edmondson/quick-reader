/*
 * Copyright (C) 2015 - 2018, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit
import Material

class AppToolbarController: ToolbarController {
    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    fileprivate var searchButton: IconButton!
    let greyBG:UIColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    open override func prepare() {
        super.prepare()
        prepareMenuButton()
        //prepareStarButton()
        //prepareSearchButton()
        prepareStatusBar()
        prepareToolbar()
    }
}

extension AppToolbarController {
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu, tintColor: .white)
        menuButton.pulseColor = .white
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.star, tintColor: .white)
        starButton.pulseColor = .white
    }
    
    fileprivate func prepareSearchButton() {
        searchButton = IconButton(image: Icon.cm.search, tintColor: .white)
        searchButton.pulseColor = .white
    }
    
    fileprivate func prepareStatusBar() {
        statusBar.backgroundColor = greyBG
        statusBar.tintColor = UIColor.black
        
        
    }
    
    fileprivate func prepareToolbar() {
        let title:String = "QUICK READ"
        let colour = UIColor.white
        

        let attributes:[NSAttributedString.Key:AnyObject] =  [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(name: "Raleway-Bold", size: 15)!,
                                                             NSAttributedString.Key.foregroundColor: colour,
                                                             (NSAttributedString.Key.kern as NSString) as NSAttributedString.Key:3.5 as AnyObject]
        let controllerTitle : NSAttributedString = NSAttributedString(string: title, attributes: attributes)


        toolbar.depthPreset = .none
        toolbar.backgroundColor = greyBG
        
        toolbar.titleLabel.attributedText = controllerTitle
        toolbar.titleLabel.textAlignment = .center
        toolbar.detailLabel.textAlignment = .left
        
        toolbar.leftViews = [menuButton]
        //toolbar.rightViews = [starButton, searchButton]
    }
    
}
