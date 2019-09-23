platform :ios, '12.1'
use_frameworks!
inhibit_all_warnings!
use_modular_headers!

def criticalTechWorks_pods 
  pod 'RealmSwift'
end

target 'CriticalTechWorks 2019 BBC News' do
	criticalTechWorks_pods
end

target 'CriticalTechWorks 2019 CNN' do
  	criticalTechWorks_pods
end

target 'CriticalTechWorks 2019 BBC News Tests' do
	pod 'Mockingjay'
	criticalTechWorks_pods
end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end