Pod::Spec.new do |s|
  s.name         = "WJAccordionView"
  s.version      = "1.0"
  s.summary      = "Non scrollable iOS Accordion View"
  s.homepage     = "https://github.com/willyjl/WJAccordionView"
  s.license      = { :type => "MIT" }
  s.author             = { "Willy Jansen" => "i@willyjansen.com" }
  s.social_media_url   = "http://twitter.com/willyjansen"
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/willyjl/WJAccordionView.git", :tag => "v#{s.version}" }
  s.source_files  = "WJAccordionView/WJAccordionView/*"
  s.dependency = "SnapKit", "~> 0.2.1"
  s.frameworks = "UIKit"
  s.requires_arc = true
end
