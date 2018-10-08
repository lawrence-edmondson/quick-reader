//
//  NewsViewCell.swift
//  quick-read
//
//  NewsViewCell extends renders ours News View by leveraging Cosmicmind's Material framework
//  Created by Lawrence Edmondson on 10/2/18.
//  Copyright © 2018 Lawrence Edmondson. All rights reserved.
//
//

import UIKit
import Material
import Graph

/**
 
 NewsViewCell extends renders ours News View by leveraging Cosmicmind's Material framework
 
 
*/

class NewsViewCell: UICollectionViewCell {
    private var spacing: CGFloat = 10
    
    /// A boolean that indicates whether the cell is the last cell.
    public var isLast = false
    
    public lazy var card: PresenterCard = PresenterCard()
    
    /// Toolbar views.
    private var toolbar: Toolbar!
    private var moreButton: IconButton!
    
    /// Presenter area.
    private var presenterImageView: UIImageView!
    
    /// Content area.
    private var contentLabel: UILabel!
    
    /// Bottom Bar views.
    private var bottomBar: Bar!
    private var dateFormatter: DateFormatter!
    private var dateLabel: UILabel!
    private var favoriteButton: IconButton!
    private var shareButton: IconButton!
    private var layoutCalled:Bool = false
    var height:CGFloat?
    var width:CGFloat?
    var id:Int?

    public var data: Post? {
        didSet {
            layoutSubviews()
        }
    }
    
    fileprivate let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.startAnimating()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let d = data else {
            return
        }
        
        self.id = d.id
        toolbar.title = d.title
        toolbar.detail = d.source
        contentLabel.text = d.content
        
        //size the card
        contentView.backgroundColor = UIColor.white
        card.frame.origin.x = 0
        card.frame.origin.y = 0
        card.frame.size.width = self.width!
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.id = data?.id
        width = contentView.frame.size.width
        layer.rasterizationScale = Screen.scale
        layer.shouldRasterize = true
        backgroundColor = nil
        prepareDateFormatter()
        prepareDateLabel()
        prepareMoreButton()
        prepareToolbar()
        prepareFavoriteButton()
        prepareShareButton()
        preparePresenterImageView()
        prepareContentLabel()
        prepareBottomBar()
        preparePresenterCard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
/**
     prepareDateFormatter prepares the date formatter
     

*/
    private func prepareDateFormatter() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }
    
    private func prepareDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = RobotoFont.regular(with: 12)
        dateLabel.textColor = Color.blueGrey.base
        dateLabel.textAlignment = .center
    }
    
    private func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreVertical, tintColor: Color.blueGrey.base)
    }
    
    private func prepareFavoriteButton() {
        favoriteButton = IconButton(image: Icon.favorite, tintColor: Color.red.base)
    }
    
    private func prepareShareButton() {
    }
    
    private func prepareToolbar() {
        toolbar = Toolbar()
        toolbar.titleLabel.font = UIFont(name: "Lato-Bold", size: 14)
        toolbar.titleLabel.numberOfLines = 3
        toolbar.heightPreset = .xlarge
        toolbar.contentEdgeInsetsPreset = .square3
        toolbar.titleLabel.textAlignment = .left
        toolbar.detailLabel.textAlignment = .left
    }
    
    private func preparePresenterImageView() {
        presenterImageView = UIImageView()
        presenterImageView.frame.size.height = 300
        presenterImageView.frame.size.width = self.width!
        presenterImageView.contentMode = .scaleAspectFill
        activityView.center = presenterImageView.center
        presenterImageView.addSubview(activityView)
        
    }
    
    private func prepareContentLabel() {
        contentLabel = UILabel()
        contentLabel.numberOfLines = 3
        contentLabel.font = UIFont(name: "Lato-Regular", size: 13)
    }
    
    private func prepareBottomBar() {
        bottomBar = Bar()
        bottomBar.heightPreset = .xlarge
        bottomBar.contentEdgeInsetsPreset = .square3
        bottomBar.dividerColor = Color.grey.lighten2
    }
    
    func preparePresenterCard() {
        card.toolbar = toolbar
        card.presenterView = presenterImageView
        card.contentView = contentLabel
        card.contentViewEdgeInsetsPreset = .square3
        card.contentViewEdgeInsets.bottom = 0
        card.bottomBar = bottomBar
        card.depthPreset = .none
        
        contentView.addSubview(card)
    }
    
    
    func setImage(image: UIImage?) {
        self.presenterImageView.image = image
        if image != nil {
            activityView.stopAnimating()
        } else {
            activityView.startAnimating()
        }
    }
}
