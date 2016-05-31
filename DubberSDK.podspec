#
# Be sure to run `pod lib lint DubberSDK.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "DubberSDK"
    s.version          = "1.14.0"

    s.summary          = "Dubber Rest API"
    s.description      = <<-DESC
                         The Dubber API features a full set of endpoints using OAuth 2.0
                         DESC

    s.platform     = :ios, '7.0'
    s.requires_arc = true

    s.framework    = 'SystemConfiguration'

    s.homepage     = "https://github.com/swagger-api/swagger-codegen"
    s.license      = "MIT"
    s.source       = { :git => "https://github.com/swagger-api/swagger-codegen.git", :tag => "#{s.version}" }
    s.author       = { "Swagger" => "apiteam@swagger.io" }

    s.source_files = 'DubberSDK/**/*'
    s.public_header_files = 'DubberSDK/**/*.h'

    s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'JSONModel', '~> 1.1'
    s.dependency 'ISO8601', '~> 0.3'
end
