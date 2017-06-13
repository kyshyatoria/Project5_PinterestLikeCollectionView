//
//  PinterestViewController.swift
//  PinterestLinkCollectionView
//
//  Created by kanchan yadav on 6/13/17.
//  Copyright © 2017 kanchan yadav. All rights reserved.
//

import UIKit
import AVFoundation

class PinterestViewController: UIViewController {
    
    @IBOutlet weak var imagesollectionView: UICollectionView!
    
    var images:[UIImage]?{
        let images = ImageManager.shared.getImages()
        print(images)
        return images
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pinterest Inspired Collection View"
        if let layout = imagesollectionView?.collectionViewLayout as? ImagesLayout {
            layout.delegate = self
        }
    }
    
    //To handle device rotation.
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        // Reload collection view.
        self.imagesollectionView.reloadData()
    }
}

//CollectionView Delegates and Datasource methods.
extension PinterestViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageCVCell = collectionView.dequeueReusableCell(withReuseIdentifier:"ImageCell", for: indexPath) as! ImageCollectionViewCell
        
        if indexPath.row < (images?.count)! {
            imageCVCell.populateCell(image:(images?[indexPath.row]))
        }
        return imageCVCell
        
    }
}

extension PinterestViewController:ImageLayoutDelegate{
    
    func collectionView(collectionView:UICollectionView, heightForPhotoAt indexPath:IndexPath , with Width:CGFloat) -> CGFloat{
        if let image = images?[indexPath.row]{
            let boundingRect = CGRect(x: 0, y: 0, width: Width, height: CGFloat(MAXFLOAT))
            let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
            return rect.size.height
        }
        return 0
    }
}




