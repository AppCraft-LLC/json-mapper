# coding: utf-8
platform :osx, '10.10'

use_frameworks!

target 'JSONMapper' do
  pod 'SwiftyJSON', '~> 3.1'
  pod 'Stencil', '~> 0.6'
  pod 'Fragaria', :podspec => 'Fragaria.podspec.json', :inhibit_warnings => true

  target 'JSONMapperTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
