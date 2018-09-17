//
//  UIScrollView.swift
//  AERecord
//
//  Created by Sergey on 17.09.2018.
//

import UIKit

extension UIScrollView {
    
    func resetZoom(animated: Bool = true) {
        setZoomScale(minimumZoomScale, animated: animated)
    }
    
    var canZoom: Bool {
        return zoomScale < maximumZoomScale
    }
    
}
