//
//  UICollectionView.swift
//  AERecord
//
//  Created by Sergey on 17.09.2018.
//

import UIKit

extension UICollectionView {
    
    var flowLayout: UICollectionViewFlowLayout? {
        return collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    var maxItemSize: CGSize {
        let sectionInset = flowLayout?.sectionInset ?? .zero
        let height = bounds.height - sectionInset.top - sectionInset.bottom
        let width = bounds.width - sectionInset.left - sectionInset.right
        return CGSize(width: width, height: height)
    }
    
    func contains(_ indexPath: IndexPath) -> Bool {
        let sections = 0..<numberOfSections
        guard sections.contains(indexPath.section) else { return false }
        let indices = 0..<numberOfItems(inSection: indexPath.section)
        return indices.contains(indexPath.row)
    }
    
}
