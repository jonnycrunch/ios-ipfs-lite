#
# Be sure to run `pod lib lint IpfsLiteApi.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IpfsLiteApi'
  s.version          = '0.1.0'
  s.summary          = 'A short description of IpfsLiteApi.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Aaron Sutula/IpfsLiteApi'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aaron Sutula' => 'hi@asutula.com' }
  s.source           = { :git => 'https://github.com/Aaron Sutula/IpfsLiteApi.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'IpfsLiteApi/Classes/**/*'

  s.static_framework = true
  
  # s.resource_bundles = {
  #   'IpfsLiteApi' => ['IpfsLiteApi/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'grpc-ipfs-lite', '0.0.1-rc1'
  
  # Base directory where the .proto files are.
  src = '../grpc-ipfs-lite/ipfs-lite'

  # We'll use protoc with the gRPC plugin.
  s.dependency '!ProtoCompiler-gRPCPlugin', '~> 1.0'

  # Pods directory corresponding to this app's Podfile, relative to the location of this podspec.
  pods_root = 'Example/Pods'
  
  # Path where Cocoapods downloads protoc and the gRPC plugin.
  protoc_dir = "#{pods_root}/!ProtoCompiler"
  protoc = "#{protoc_dir}/protoc"
  plugin = "#{pods_root}/!ProtoCompiler-gRPCPlugin/grpc_objective_c_plugin"

  # Directory where you want the generated files to be placed. This is an example.
  dir = "IpfsLiteApi/Classes"

  # Run protoc with the Objective-C and gRPC plugins to generate protocol messages and gRPC clients.
  # You can run this command manually if you later change your protos and need to regenerate.
  # Alternatively, you can advance the version of this podspec and run `pod update`.
  s.prepare_command = <<-CMD
    mkdir -p #{dir}
    #{protoc} \
        --plugin=protoc-gen-grpc=#{plugin} \
        --objc_out=#{dir} \
        --grpc_out=#{dir} \
        -I #{src} \
        -I #{protoc_dir} \
        #{src}/*.proto
  CMD

  # The --objc_out plugin generates a pair of .pbobjc.h/.pbobjc.m files for each .proto file.
  # s.subspec 'Messages' do |ms|
  #   ms.source_files = "#{dir}/*.pbobjc.{h,m}"
  #   ms.header_mappings_dir = dir
  #   ms.requires_arc = false
  #   # The generated files depend on the protobuf runtime.
  #   ms.dependency 'Protobuf'
  # end

  # # The --objcgrpc_out plugin generates a pair of .pbrpc.h/.pbrpc.m files for each .proto file with
  # # a service defined.
  # s.subspec 'Services' do |ss|
  #   ss.source_files = "#{dir}/*.pbrpc.{h,m}"
  #   ss.header_mappings_dir = dir
  #   ss.requires_arc = true
  #   # The generated files depend on the gRPC runtime, and on the files generated by `--objc_out`.
  #   ss.dependency 'gRPC-ProtoRPC'
  #   ss.dependency "#{s.name}/Messages"
  # end

  s.pod_target_xcconfig = {
    # This is needed by all pods that depend on Protobuf:
    'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1',
    # This is needed by all pods that depend on gRPC-RxLibrary:
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
  }
end
