//
//  NewsCollectionView.swift
//  quick-read
//
//  NewsCollectionView is reponsible for creating a News Collection View
//  Created by Lawrence Edmondson on 10/2/18.
//  Copyright © 2018 Lawrence Edmondson. All rights reserved.
//
//

import IGListKit
import UIKit
import Material

final class NewsCollectionView: ListSectionController, ListWorkingRangeDelegate {
    
    private var height: CGFloat?
    private var downloadedImage: UIImage?
    private var task: URLSessionDataTask?
    private var post:Post?
    
    deinit {
        task?.cancel()
    }
    
    override init() {
        super.init()
        workingRangeDelegate = self
    }
    
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat = collectionContext?.containerSize.width ?? 0
        var height:CGFloat = (collectionContext?.containerSize.height)! * 0.80
        return CGSize(width: width, height: height)
    }
    
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: NewsViewCell.self, for: self, at: index)
        if let cell = cell as? NewsViewCell {
            cell.data = self.post
            if (self.downloadedImage == nil) {
                getImage()
            }
            cell.setImage(image: downloadedImage)
        } else {
        }
        return cell
    }
    
    override func didDeselectItem(at index: Int) {
        let url:String! = self.post?.detail
        let detailStoryBoard = UIStoryboard(name: "DetailView", bundle: Bundle.main)
        let detailViewController:DetailViewController = detailStoryBoard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        detailViewController.detailUrl = url
        var presenter:NewsViewCollectionController!
        presenter?.navigationController?.navigationBar.isHidden = false
        presenter?.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func didUpdate(to object: Any) {
        let item:Post = (object as? Post)!
        self.post = item
    }
    
    func getImage() {
        guard downloadedImage == nil,
            task == nil,
            let urlString = self.post?.image_url,
            let url = URL(string: urlString)
            else { return }
            task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                return print("Error downloading \(urlString): " + String(describing: error))
            }
            DispatchQueue.main.async {
                self.downloadedImage = image
                if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? NewsViewCell {
                    cell.setImage(image: image)
                }
            }
        }
        task?.resume()

    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        getImage()
    }
    
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {
        getImage()
    }
}
