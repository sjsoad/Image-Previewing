Pod::Spec.new do |s|

# 1
s.platform = :ios
s.swift_version = '4.0'
s.ios.deployment_target = '11.0'
s.name = "SKImagePreviewing"
s.summary = "SKImagePreviewing for displaying set of images"
s.requires_arc = true

# 2
s.version = "0.0.3"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Serhii Kostian" => "skostyan666@gmail.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/sjsoad/Image-Previewing"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/sjsoad/Image-Previewing.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"

# 8
s.source_files = "ImagePreviewing/**/*.{swift,xib}"

s.resource_bundles = {
    "ImagePreviewing" => ["ImagePreviewing/**/*.xib"]
}

#10
s.dependency 'AlamofireImage'
s.dependency 'SKDataSources'

end
