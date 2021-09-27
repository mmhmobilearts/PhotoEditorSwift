Pod::Spec.new do |spec|

  spec.platform = :ios
  spec.name         = "PhotoEditorSwift"
  spec.version      = "1.0.0"
  spec.requires_arc = true
  spec.summary      = "A short description of PhotoEditorSwift."
  spec.description  = <<-DESC
  A much much longer description of PhotoEditorSwift.
                      DESC
  spec.homepage     = 'https://github.com/mmhmobilearts/PhotoEditorSwift'
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Mohamad" => "h.mohammad@smartmobiletech.org" }
  spec.source = { 
    :git => 'https://github.com/mmhmobilearts/PhotoEditorSwift.git', 
    :tag => spec.version.to_s 
  }
  spec.framework = 'UIKit'
  spec.dependency 'iOSPhotoEditor'
  spec.source_files  = "PhotoEditorSwift/**/*.{swift}"
  spec.swift_version = '5'
  spec.ios.deployment_target = '14.0'

end
