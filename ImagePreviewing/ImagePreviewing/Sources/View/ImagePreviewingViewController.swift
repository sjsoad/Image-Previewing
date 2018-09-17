//
//  ImagePreviewingViewController.swift
//  SKUtils
//
//  Created by Sergey on 22.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit
import SKDataSources

open class ImagePreviewingViewController: UIViewController, ImagePreviewingInterface, UICollectionViewDelegateFlowLayout {
    
    public var presenter: ImagePreviewingOutput?
    
    @IBOutlet public private(set) weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle -
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup(collectionView)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Public -
    
    open func setup(_ collectionView: UICollectionView) {
        let bundle = Bundle(for: ImagePreviewCell.self)
        let cellNib = UINib(nibName: ImagePreviewCell.nibName, bundle: bundle)
        collectionView.register(cellNib, forCellWithReuseIdentifier: ImagePreviewCell.reuseIdentifier)
        collectionView.flowLayout?.sectionInset = .zero
        collectionView.flowLayout?.scrollDirection = .horizontal
    }
    
    // MARK: - ImagePreviewingInterface -
    
    public func reload(with dataSource: CollectionViewArrayDataSourceRepresentable) {
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    public func scroll(toItemAt indexPath: IndexPath, aniamted: Bool) {
        collectionView.layoutIfNeeded()
        guard collectionView.contains(indexPath) else { return }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: aniamted)
    }
    
    public func indexPathesOfVisibleCells() -> [IndexPath] {
        return collectionView.indexPathsForVisibleItems
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout -
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.maxItemSize
    }
    
}
