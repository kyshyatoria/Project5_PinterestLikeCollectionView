//
//  ImageCollectionViewCell.swift
//  PinterestLinkCollectionView
//
//  Created by kanchan yadav on 6/13/17.
//  Copyright © 2017 kanchan yadav. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!

    func populateCell(image:UIImage?){
        //make sure to clear the cell before populating it with again.
        self.clearCell()
        imageView.image = image
    }
    
    //Clears the Cell so that if Cell is reused, it doesn't contain old data.
    private func clearCell(){
        self.imageView.image = nil
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let  attributes = layoutAttributes as? ImageLayoutAttributes{
            imageHeightConstraint.constant = attributes.photoHeight
        }
    }
}



