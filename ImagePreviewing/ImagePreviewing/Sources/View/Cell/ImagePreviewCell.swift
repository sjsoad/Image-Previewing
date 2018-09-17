//
//  ImagePreviewCell.swift
//  SKUtils
//
//  Created by Sergey on 22.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//
// use APIClient for executing this requests

import UIKit
import Foundation
import SKDataSources
import AlamofireImage

open class ImagePreviewCell: UICollectionViewCell, UIScrollViewDelegate, ImagePreviewCellInterface {
    
    private var miminumZoomScale: CGFloat = 1
    private var maximumZoomScale: CGFloat = 3
    
    public var presenter: ImagePreviewOutput?
    
    @IBOutlet public private(set) weak var activity: UIActivityIndicatorView!
    @IBOutlet public private(set) weak var scroll: UIScrollView!
    @IBOutlet public private(set) weak var imagePreview: UIImageView!
    
    @IBOutlet public private(set) weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet public private(set) weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet public private(set) weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet public private(set) weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet public private(set) weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet public private(set) weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        imagePreview.af_cancelImageRequest()
        imagePreview.image = nil
        activity.startAnimating()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        addDoubleTapGesture()
    }
    
    // MARK: - Private -
    
    private var yOffset: CGFloat {
        return max(0, (bounds.size.height - imagePreview.frame.height) * 0.5)
    }

    private var xOffset: CGFloat {
        return max(0, (bounds.size.width - imagePreview.frame.width) * 0.5)
    }
    
    private func maximumZoom(for image: UIImage) -> CGFloat {
        let aspectWidth = image.calculateAspectWidth(for: bounds.size.width)
        let aspectHeight = image.calculateAspectHeight(for: bounds.size.height)
        let minAspectRation = image.minAspectRation(aspectWidth, aspectHeight)
        return max(minAspectRation, maximumZoomScale)
    }
    
    @objc private func doubleTapped(_ sender: UITapGestureRecognizer) {
        guard scroll.canZoom else {
            scroll.resetZoom()
            return }
        scroll.zoom(to: sender.locationRect, animated: true)
    }
    
    private func addDoubleTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(_:)))
        tap.numberOfTapsRequired = 2
        imagePreview.addGestureRecognizer(tap)
    }
    
    private func layoutImage() {
        layoutIfNeeded()
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        layoutIfNeeded()
    }
    
    private func setupZoom(for image: UIImage) {
        scroll.minimumZoomScale = miminumZoomScale
        scroll.maximumZoomScale = maximumZoom(for: image)
    }
    
    private func setupSize(of image: UIImage) {
        let size = image.size(thatFits: bounds.size)
        imageViewWidthConstraint.constant = size.width
        imageViewHeightConstraint.constant = size.height
        layoutIfNeeded()
    }
    
    private func update(for image: UIImage) {
        setupSize(of: image)
        setupZoom(for: image)
        scroll.resetZoom()
        layoutImage()
    }
    
    // MARK: - ImagePreviewCellInterface -
    
    public func set(_ image: UIImage) {
        imagePreview.image = image
        activity.stopAnimating()
        update(for: image)
    }

    public func set(_ imageURL: URL, placeholderImage: UIImage?) {
        imagePreview.af_setImage(withURL: imageURL, placeholderImage: placeholderImage) { [weak self] (response) in
            guard let image = response.result.value else { return }
            self?.set(image)
        }
    }
    
    // MARK: - UIScrollViewDelegate -
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imagePreview
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        layoutImage()
    }
    
}

// MARK: - ViewType -

extension ImagePreviewCell: ViewType, Reusable, Nibable {
    
    public func set(presenter: PresenterType) {
        self.presenter = presenter as? ImagePreviewOutput
    }
    
}
