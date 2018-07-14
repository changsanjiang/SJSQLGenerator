#
# Be sure to run `pod lib lint SJSQLGenerator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SJSQLGenerator'
  s.version          = '0.0.1'
  s.summary          = '便利的构造SQL语句.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
最近在学习SQL语句, 为加深学习效果以及后期防止遗忘, 便使用OC写了一个便利构造SQL语句的库.
                       DESC

  s.homepage         = 'https://gitee.com/changsanjiang/SJSQLGenerator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'changsanjiang@gmail.com' => 'changsanjiang@gmail.com' }
  s.source           = { :git => 'https://gitee.com/changsanjiang/SJSQLGenerator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SJSQLGenerator/*.{h,m}'

end
