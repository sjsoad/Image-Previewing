//
//  ImagePreviewRepresentable.swift
//  Pods
//
//  Created by Sergey on 17.09.2018.
//  
//

import Foundation

public protocol ImagePreviewRepresentable {

    var image: UIImage? { get }
    var placeholderImage: UIImage? { get }
    var imageURL: URL? { get }
    
}
