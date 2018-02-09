
Pod::Spec.new do |s|

  s.name         = "UDID"
  s.version      = "1.0.0"
  s.summary      = "以bundleID 为key 保存uuid 到 keychain， 作为设备唯一识别码"
  s.description  = <<-DESC
        以bundleID 为key 保存uuid 到 keychain， 作为设备唯一识别码
                   DESC
  s.homepage     = "https://github.com/qibaozhen/UDID.git"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "齐春宝" => "@qqbbzz@126.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/qibaozhen/UDID.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"
  s.public_header_files = "Classes/*.h"
  s.requires_arc = true


end
