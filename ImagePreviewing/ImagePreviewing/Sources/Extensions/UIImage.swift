//
//  UIImage.swift
//  SKImagePreviewing
//
//  Created by Sergey on 17.09.2018.
//

import UIKit

extension UIImage {
    
    func size(thatFits size: CGSize) -> CGSize {
        let aspectWidth = calculateAspectWidth(for: size.width)
        let aspectHeight = calculateAspectHeight(for: size.height)
        let aspectRatio = minAspectRation(aspectWidth, aspectHeight)
        return newSize(with: aspectRatio)
    }
    
    func calculateAspectWidth(for width: CGFloat) -> CGFloat {
        return width / size.width
    }
    
    func calculateAspectHeight(for height: CGFloat) -> CGFloat {
        return height / size.height
    }
    
    func minAspectRation(_ aspectWidth: CGFloat, _ aspectHeight: CGFloat) -> CGFloat {
        return min(aspectWidth, aspectHeight)
    }
    
    func maxAspectRation(_ aspectWidth: CGFloat, _ aspectHeight: CGFloat) -> CGFloat {
        return max(aspectWidth, aspectHeight)
    }
    
    func newSize(with aspectRatio: CGFloat) -> CGSize {
        var newSize = CGSize.zero
        newSize.width = size.width * aspectRatio
        newSize.height = size.height * aspectRatio
        return newSize
    }
    
}
