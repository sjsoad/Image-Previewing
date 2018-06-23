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

open class ImagePreviewCell: UICollectionViewCell, DataSourceObjectInterface, Reusable, Nibable, ImagePreviewCellInterface, UIScrollViewDelegate {
    
    private var miminumZoomScale: CGFloat = 1
    private var maximumZoomScale: CGFloat = 3
    
    public var presenter: ImagePreviewOutput?
    
    @IBOutlet private(set) public weak var activity: UIActivityIndicatorView!
    @IBOutlet private(set) public weak var scroll: UIScrollView!
    @IBOutlet private(set) public weak var imagePreview: UIImageView!
    
    @IBOutlet private(set) public weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private(set) public weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private(set) public weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private(set) public weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet private(set) public weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private(set) public weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        imagePreview.af_cancelImageRequest()
        activity.startAnimating()
        imagePreview.image = nil
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        addDoubleTapGesture()
    }
    
    // MARK: - Public -
    
    @objc private func doubleTapped(_ sender: UITapGestureRecognizer) {
        guard scroll.zoomScale < scroll.maximumZoomScale else {
            resetZoomScale()
            return }
        let location = sender.location(in: imagePreview)
        let rect = CGRect(origin: location, size: .zero)
        scroll.zoom(to: rect, animated: true)
    }
    
    // MARK: - Private -
    
    private func addDoubleTapGesture() {
        imagePreview.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(_:)))
        tap.numberOfTapsRequired = 2
        imagePreview.addGestureRecognizer(tap)
    }
    
    private func  resetZoomScale() {
        scroll.setZoomScale(scroll.minimumZoomScale, animated: true)
    }
    
    private func layoutImage() {
        layoutIfNeeded()
        let yOffset = max(0, (bounds.size.height - imagePreview.frame.height) * 0.5)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        let xOffset = max(0, (bounds.size.width - imagePreview.frame.width) * 0.5)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        layoutIfNeeded()
    }
    
    private func calculateZoomScale(for image: UIImage) {
        let size = image.size(thatFits: bounds.size)
        scroll.minimumZoomScale = miminumZoomScale
        var calculatedMaximumZoomScale = maximumZoomScale
        if size.width < size.height {
            calculatedMaximumZoomScale = (bounds.size.width / size.width)
        } else {
            calculatedMaximumZoomScale = (bounds.size.height / size.height)
        }
        scroll.maximumZoomScale = max(calculatedMaximumZoomScale, maximumZoomScale)
    }
    
    private func calculateSize(of image: UIImage) {
        let size = image.size(thatFits: bounds.size)
        imageViewWidthConstraint.constant = size.width
        imageViewHeightConstraint.constant = size.height
        layoutIfNeeded()
    }
    
    private func reset(for image: UIImage) {
        calculateSize(of: image)
        calculateZoomScale(for: image)
        resetZoomScale()
        layoutImage()
    }
    
    // MARK: - DataSourceObjectInterface -
    
    public func set(presenter: DataSourceObjectPresenter) {
        self.presenter = presenter as? ImagePreviewOutput
    }
    
    // MARK: - ImagePreviewCellInterface -
    
    public func set(_ image: UIImage) {
        imagePreview.image = image
        activity.stopAnimating()
        reset(for: image)
    }

    public func set(_ imageURL: URL, placeholderImage: UIImage?) {
        imagePreview.af_setImage(withURL: imageURL, placeholderImage: placeholderImage) { [weak self] (response) in
            guard let image = response.result.value else { return }
            self?.activity.stopAnimating()
            self?.reset(for: image)
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

private extension UIImage {

        func size(thatFits size: CGSize) -> CGSize {
            let aspectWidth = calculateAspectWidth(width: size.width)
            let aspectHeight = calculateAspectHeight(height: size.height)
            let aspectRatio = minAspectRation(aspectWidth: aspectWidth, aspectHeight: aspectHeight)
            return newSize(with: aspectRatio)
        }
        
        // MARK: - Private -
        
        private func calculateAspectWidth(width: CGFloat) -> CGFloat {
            return width / size.width
        }
        
        private func calculateAspectHeight(height: CGFloat) -> CGFloat {
            return height / size.height
        }
        
        private func minAspectRation(aspectWidth: CGFloat, aspectHeight: CGFloat) -> CGFloat {
            return min(aspectWidth, aspectHeight)
        }
        
        private func maxAspectRation(aspectWidth: CGFloat, aspectHeight: CGFloat) -> CGFloat {
            return max(aspectWidth, aspectHeight)
        }
        
        private func newSize(with aspectRatio: CGFloat) -> CGSize {
            var newSize = CGSize.zero
            newSize.width = size.width * aspectRatio
            newSize.height = size.height * aspectRatio
            return newSize
        }
    
}
