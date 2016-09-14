#
# Be sure to run `pod lib lint SWErrorRecovery.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SWErrorRecovery'
  s.version          = '2.0.0'
  s.summary          = 'SWErrorRecovery contains class and extension that facilitate crafting error and showing it.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

# s.description      = <<-DESC
#TODO: Add long description of the pod here.
#                       DESC

  s.homepage         = 'https://github.com/sarunw/SWErrorRecovery'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sarun Wongpatcharapakorn' => 'artwork.th@gmail.com' }
  s.source           = { :git => 'https://github.com/sarunw/SWErrorRecovery.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sarunw'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SWErrorRecovery/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SWErrorRecovery' => ['SWErrorRecovery/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
