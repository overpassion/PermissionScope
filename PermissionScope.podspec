Pod::Spec.new do |s|
  s.name = 'PermissionScope'
<<<<<<< HEAD
  s.version = '1.1.1'
=======
  s.version = '1.0.2'
>>>>>>> 8e7df5b5b676363b680a9fc0578ff232bcf8be5d
  s.license = 'MIT'
  s.summary = 'A Periscope-inspired way to ask for iOS permissions'
  s.homepage = 'https://github.com/nickoneill/PermissionScope'
  s.social_media_url = 'https://twitter.com/objctoswift'
  s.authors = { "Nick O'Neill" => 'nick.oneill@gmail.com' }
  s.source = { :git => 'https://github.com/nickoneill/PermissionScope.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'PermissionScope/*.swift'

  s.requires_arc = true
end
