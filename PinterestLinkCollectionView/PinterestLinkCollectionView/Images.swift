//
//  Images.swift
//  PinterestLinkCollectionView
//
//  Created by kanchan yadav on 6/13/17.
//  Copyright © 2017 kanchan yadav. All rights reserved.
//

import UIKit

struct Image{
    var image:UIImage
}

//Used to store image specific data.
final class ImageManager {
    static var shared = ImageManager()
    private init() {}

    func getImages()->[UIImage]{
        var image = UIImage(named:"1")
        var images:[UIImage] = []
        for i  in 1..<21{
            let index = String(i)
            print(index)
            image = UIImage(named: index)
            images.append(image!)
        }
        print(images)
        return images
    }
}




