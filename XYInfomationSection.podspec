

Pod::Spec.new do |s|

  s.name             		= 'XYInfomationSection'
  s.version          		= '0.1.1'
  s.summary          		= 'a custom formdata component view, it decouple、elegant and efficient.'
  s.description      		= <<-DESC
								   一组可定制化的表单组件，该组件将表单录入组件化，模块化。
								   支持方便处理用户事件如:项目录入监听、内容条目折叠展示、数据动态刷新、条目禁用、一键校验录入内容等。
								   本模块提供基类控制器，支持使用者只关心业务代码，方便实用。
		                       DESC

  s.homepage         		= 'https://github.com/xiaoyouPrince/SectionDemo'
  s.license          		= { :type => 'MIT', :file => 'LICENSE' }
  s.author           		= { 'xiaoyouPrince' => 'xiaoyouPrince@163.com' }
  s.source           		= { :git => 'https://github.com/xiaoyouPrince/SectionDemo.git', :tag => s.version.to_s }

  s.ios.deployment_target 	= '8.0'
  s.requires_arc 			= true

  s.source_files 			= 'SectionDemo/XYInfomationSection/**/*.{h,m,xib}'
  s.resource_bundles 		= {
							    'XYInfomationSection' => ['SectionDemo/XYInfomationSection/XYInfomationSection.bundle/*.png']
							  }

  s.dependency 'Masonry'
end
