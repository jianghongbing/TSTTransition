Pod::Spec.new do |s|
  s.name         = "TSTTransition"
  s.version      = "1.0.0"
  s.summary      = "A custom ViewController Transition, similar to Tecent Sports App"
  s.homepage     = "https://github.com/jianghongbing/TSTTransition"
  s.license      = "MIT"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/jianghongbing/TSTTransition.git", :tag => "#{s.version}" }
  s.source_files  = "TSTTransition/*.{h,m}"
  s.framework  = "UIKit", "Foundation", "CoreGraphics"
  s.author = "jianghongbing"
  s.requires_arc = true
end
