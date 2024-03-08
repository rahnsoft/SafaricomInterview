# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

def globalPods
  pod 'RxSwift', '~> 6.1.0'
  pod 'SwiftLint', '~> 0.42.0'
  pod 'Log'
end

def globalTestPods
  pod 'RxBlocking', '~> 6.1.0'
  pod 'RxTest', '~> 6.1.0'
end

def swinjectPod
  pod 'Swinject', '~> 2.7.1'
end

def networkPod
  pod 'Alamofire', '~> 5.4.4'
  pod 'ReachabilitySwift', '~> 5.0.0'
  pod 'RxAlamofire', '~> 6.1.1'
end

target 'Interview' do
  use_frameworks!

  # Pods for Interview
  globalPods
  swinjectPod
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'RxDataSources', '~> 5.0.0'
  pod 'RxGesture', '~> 4.0.0'
  pod 'libPhoneNumber-iOS', '~> 0.9.15'
  pod 'IQKeyboardManagerSwift', '~> 6.5.5'
  pod 'NotificationBannerSwift', '~> 3.0.0'
  
  target 'InterviewTests' do
    inherit! :search_paths
    # Pods for testing
    globalTestPods
  end

  target 'InterviewUITests' do
    # Pods for testing
    inherit! :search_paths
  end

end

target 'InterviewData' do
  use_frameworks!

  # Pods for InterviewData
  globalPods
  swinjectPod
  networkPod
  pod 'RealmSwift', '~> 10.7.0'
  pod 'libPhoneNumber-iOS', '~> 0.9.15'
  pod 'KeychainSwift', '~> 19.0'
  
  target 'InterviewDataTests' do
    # Pods for testing
    globalTestPods
  end

end

target 'InterviewDependencyInjection' do
  use_frameworks!

  # Pods for InterviewDependencyInjection
  swinjectPod
end

target 'InterviewDomain' do
  use_frameworks!

  # Pods for InterviewDomain
  globalPods

  target 'InterviewDomainTests' do
    # Pods for testing
    globalTestPods
  end

end

deployment_target = '13.0'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end

    end
end