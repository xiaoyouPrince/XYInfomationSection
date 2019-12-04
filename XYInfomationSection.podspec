#
# Be sure to run `pod lib lint XYInfomationSection.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XYInfomationSection'
  s.version          = '0.1.0'
  s.summary          = 'a custom formdata component view, it decouple、elegant and efficient.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
一组可定制化的表单组件，该组件将表单录入组件化，模块化。支持方便处理用户事件如:项目录入监听、内容条目折叠展示、数据动态刷新、条目禁用、一键校验录入内容等。本模块提供基类控制器，支持使用者只关心业务代码，方便实用。
                       DESC

  s.homepage         = 'https://github.com/xiaoyouPrince/SectionDemo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaoyouPrince' => 'xiaoyouPrince@163.com' }
  s.source           = { :git => 'https://github.com/xiaoyouPrince/SectionDemo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

#  s.source_files = 'XYInfomationSection/Classes/**/*'
    s.subspec 'Core' do |core|
      core.source_files = 'XYInfomationSection/Classes/**/*'
    end
  
   s.resource_bundles = {
     'XYInfomationSection' => ['XYInfomationSection/Assets/*.png']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
#   s.dependency 'Masonry'
end
