Pod::Spec.new do |s|
  s.name                    = 'Swissors'
  s.version                 = '0.0.1'
  s.summary                 = 'Swift utilities'
  s.homepage                = 'https://github.com/elegion/ios-Swissors'
  s.license                 = 'MIT'
  s.author                  = { 'Ilya Kulebyakin' => 'ilya.kulebyakin@e-legion.com' }
  s.source                  = { :git => 'https://github.com/elegion/ios-Swissors.git', :tag => "v#{s.version}" }
  
  s.ios.deployment_target   = '8.0'
  s.requires_arc            = true

  s.source_files            = 'Source'

  s.frameworks              = 'Foundation', 'UIKit'

end
