Pod::Spec.new do |s|
  s.name         = "TSTTransition"
  s.version      = "1.0.0"
  s.summary      = "A custom ViewController Transition, similar to Tecent Sports App"
  s.homepage     = "https://github.com/jianghongbing/TSTTransition"
  s.license      = "MIT"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/jianghongbing/TSTTransition.git", :tag => "#{s.version}" }
  s.source_files  = "TSTTransition/*.{h,m}"
  s.public_header_files = "TSTTransition/TSTTransitionHeader.h"
  s.framework  = "UIKit"
  s.requires_arc = true
end
