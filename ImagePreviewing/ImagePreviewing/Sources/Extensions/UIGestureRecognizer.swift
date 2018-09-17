//
//  UIGestureRecognizer.swift
//  AERecord
//
//  Created by Sergey on 17.09.2018.
//

import UIKit

extension UIGestureRecognizer {
    
    var locationRect: CGRect {
        return CGRect(origin: location(in: view), size: .zero)
    }
    
}
