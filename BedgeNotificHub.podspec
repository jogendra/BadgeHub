#
# Be sure to run `pod lib lint BedgeNotificHub.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BedgeNotificHub'
  s.version          = '0.1.0'
  s.summary          = 'A way to quickly add a notification bedge icon to any view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Make any UIView a full fledged notification center. A way to quickly add a notification bedge icon to any view.
                       DESC

  s.homepage         = 'https://github.com/jogendra/BedgeNotificHub'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jogendra' => 'jogendra.iitbhu@gmail.com' }
  s.source           = { :git => 'https://github.com/jogendra/BedgeNotificHub.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/imjog24'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'

  s.source_files = 'BedgeNotificHub/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BedgeNotificHub' => ['BedgeNotificHub/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
