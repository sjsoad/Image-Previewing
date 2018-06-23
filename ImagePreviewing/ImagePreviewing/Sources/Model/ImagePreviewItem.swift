//
//  ImagePreviewItem.swift
//  SKUtils
//
//  Created by Sergey on 22.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

open class ImagePreviewItem: NSObject {

    public var image: UIImage?
    public var placeholderImage: UIImage?
    public var imageURL: URL?
    
    public init(image: UIImage?) {
        self.image = image
    }
    
    public init(imageURL: URL?, placeholderImage: UIImage? = nil) {
        self.imageURL = imageURL
        self.placeholderImage = placeholderImage
    }
    
}
