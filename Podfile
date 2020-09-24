platform :ios, '13.0'
use_frameworks!

def marvelpedia_pods
  pod 'Swinject'
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'Cache'
end

def unitTestsMarvelpedia_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'Marvelpedia' do
  marvelpedia_pods
end

target 'MarvelpediaTests' do
  marvelpedia_pods
  unitTestsMarvelpedia_pods
end

target 'MarvelpediaUITests' do
  marvelpedia_pods
end
