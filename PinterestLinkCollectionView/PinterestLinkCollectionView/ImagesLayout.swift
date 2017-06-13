//
//  ImagesLayout.swift
//  UberCodingChallengeKY
//
//  Created by kanchan yadav on 6/10/17.
//  Copyright © 2017 kanchan yadav. All rights reserved.
//

import UIKit

protocol ImageLayoutDelegate:class {
    // Method to ask the delegate for the height of the image
    func collectionView(collectionView:UICollectionView, heightForPhotoAt indexPath:IndexPath , with Width:CGFloat) -> CGFloat
}

class ImagesLayout: UICollectionViewLayout {
    
        //1. Pinterest Layout Delegate
        var delegate:ImageLayoutDelegate?

        //2. Configurable properties
        var numberOfColumns = 2
        var cellPadding: CGFloat = 5.0

        //3. Array to keep a cache of attributes.
        private var attributesCache = [ImageLayoutAttributes]()

        //4. Content height and size
        private var contentHeight:CGFloat  = 0.0
        private var contentWidth: CGFloat {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.width - (insets.left + insets.right)
        }
    
        override func prepare() {
            // 1. Only calculate once
            if attributesCache.isEmpty {
//
                // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
                let columnWidth = contentWidth / CGFloat(numberOfColumns)
                var xOffset = [CGFloat]()
                for column in 0 ..< numberOfColumns {
                    xOffset.append(CGFloat(column) * columnWidth )
                }
                var column = 0
                var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
//
                // 3. Iterates through the list of items in the first section
                for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
//
                    let indexPath = IndexPath(item: item, section: 0)
                    // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
                    let width = columnWidth - cellPadding*2
                    let photoHeight = delegate?.collectionView(collectionView: collectionView!, heightForPhotoAt: indexPath , with:width)
                    let height = cellPadding +  photoHeight! + cellPadding
                    let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                    let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

//                     5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                    let attributes = ImageLayoutAttributes(forCellWith: indexPath)
                    attributes.photoHeight = photoHeight ?? 0
                    attributes.frame = insetFrame
                    attributesCache.append(attributes)

//                     6. Updates the collection view content height
                    contentHeight = max(contentHeight, frame.maxY)
                    yOffset[column] = yOffset[column] + height
                    
                    if column >= numberOfColumns-1 {
                        column = 0
                    }else {
                        column = column+1
                    }
                }
            }
        }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in attributesCache {
            if attributes.frame.intersects(rect){
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}


class ImageLayoutAttributes:UICollectionViewLayoutAttributes {
    
    // Custom attribute
    var photoHeight: CGFloat = 0.0
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! ImageLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? ImageLayoutAttributes {
            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}

