Pod::Spec.new do |s|
  s.name         = 'SwiftUIX-Hi'
  s.version      = '0.2.3.1'
  s.summary      = 'A comprehensive library for extending SwiftUI capabilities.'
  s.description  = <<-DESC
SwiftUIX attempts to fill the gaps of the missing features of SwiftUI, providing solutions to common problems faced by developers.
					DESC
  s.homepage     = 'https://github.com/tospery/SwiftUIX'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'YangJianxiang' => 'tospery@gmail.com' }
  s.source       = { :git => 'https://github.com/tospery/SwiftUIX.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.swift_version = '5.3'
  s.ios.deployment_target = '16.0'
  s.frameworks = 'Foundation', 'UIKit', 'SwiftUI'
  s.source_files = 'Sources/**/*.{swift,h}'

end
