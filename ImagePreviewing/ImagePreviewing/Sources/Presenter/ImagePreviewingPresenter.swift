//
//  ImagePreviewingPresenter.swift
//  SKUtils
//
//  Created by Sergey on 22.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import Foundation
import SKDataSources

public protocol ImagePreviewingInterface: class {
    
    func reload(with dataSource: CollectionViewArrayDataSourceRepresentable)
    func scroll(toItemAt indexPath: IndexPath, aniamted: Bool)
    func indexPathesOfVisibleCells() -> [IndexPath]
}

public protocol ImagePreviewingOutput {
    
    func viewDidLoad()
    
}

open class ImagePreviewingPresenter: NSObject, ImagePreviewingOutput {
    
    public private(set) weak var view: ImagePreviewingInterface?
    public private(set) var previewItems: [ImagePreviewRepresentable]
    public private(set) var initialItemIndex: Int
    
    private var dataSource: CollectionViewArrayDataSourceRepresentable = {
        return CollectionViewArrayDataSource(with: [DefaultSection(with: [])])
    }()
    
    public init(with view: ImagePreviewingInterface, previewItems: [ImagePreviewRepresentable], initialItemIndex: Int) {
        self.view = view
        self.previewItems = previewItems
        self.initialItemIndex = initialItemIndex
    }
    
    // MARK: - Public -
    
    open func dataSourseObjects(from previewItems: [ImagePreviewRepresentable]) -> [PresenterType] {
        return previewItems.map({ ImagePreviewCellPresenter(with: $0, cellIdentifier: ImagePreviewCell.reuseIdentifier) })
    }
    
    public func currentVisibleItems() -> [ImagePreviewRepresentable] {
        guard let indexPathesOfVisibleCells = view?.indexPathesOfVisibleCells() else { return [] }
        let presenters: [ImagePreviewCellPresenter] = indexPathesOfVisibleCells.compactMap({ dataSource.item(at: $0) })
        return presenters.compactMap({ $0.model })
    }
    
    // MARK: - ImagePreviewingPresenterOutput -
    
    open func viewDidLoad() {
        dataSource.append(with: dataSourseObjects(from: previewItems), toSectionAt: 0, handler: { [weak self] (_) in
            guard let `self` = self else { return }
            self.view?.reload(with: self.dataSource)
            let indexPath = IndexPath(item: self.initialItemIndex, section: 0)
            self.view?.scroll(toItemAt: indexPath, aniamted: false)
        })
    }
    
}
