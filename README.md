# Image-Previewing  

## How to use  

1. Create ImagePreviewItem objects

`open class ImagePreviewItem: NSObject {`  

    `public var image: UIImage?`  
    `public var placeholderImage: UIImage?`  
    `public var imageURL: URL?`  
    
    `public init(image: UIImage?) {`  
        `self.image = image`  
    `}`  
    
    `public init(imageURL: URL?, placeholderImage: UIImage? = nil) {`  
        `self.imageURL = imageURL`  
        `self.placeholderImage = placeholderImage`  
    `}`  
    
`}`  

2. Set initial item index  
3. Init  

`let viewController = ImagePreviewingViewController()`  
`let presenter = ImagePreviewingPresenter(with: viewController, previewItems: previewItems, initialItemIndex: initialItemIndex)`  
`viewController.presenter = presenter`  

4. Last thing, make navigation for this controller, because currently it douesn't have any navigation inside.
You can push it or init navigation controller with root viewcontroller and present it.

### You can inherit from all classes from this pod and write anything you need
