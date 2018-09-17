//
//  ImagePreviewCellPresenter.swift
//  SKUtils
//
//  Created by Sergey on 22.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import Foundation
import SKDataSources

public protocol ImagePreviewCellInterface: class {
    
    func set(_ image: UIImage)
    func set(_ imageURL: URL, placeholderImage: UIImage?)
    
}

public protocol ImagePreviewOutput {
    
}

open class ImagePreviewCellPresenter {

    public private(set) weak var view: ImagePreviewCellInterface?
    public let reuseIdentifier: String
    public let model: ImagePreviewRepresentable
    
    public init(with objectModel: ImagePreviewRepresentable, cellIdentifier: String) {
        self.model = objectModel
        self.reuseIdentifier = cellIdentifier
    }

}

// MARK: - ImagePreviewOutput -

extension ImagePreviewCellPresenter: ImagePreviewOutput {
    
}

// MARK: - ViewType -

extension ImagePreviewCellPresenter: PresenterType {
    
    public func set(view: ViewType) {
        self.view = view as? ImagePreviewCellInterface
    }
    
    public func configure() {
        if let image = model.image {
            view?.set(image)
        } else if let url = model.imageURL {
            view?.set(url, placeholderImage: model.placeholderImage)
        }
    }
    
}
