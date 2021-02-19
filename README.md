# XYInfomationSection

一组可自定义的表单组件 **XYInfomationSection**.

### 更新

**Version 1.0.3 2021年2月19日**
1. XYInfomationBaseViewController 优化回调，方便回调时知道是第几组

**Version 1.0.2 2021年2月14日**
1. XYInfomationSection 新增 separatorHeight 属性，方便直接通过一个组实现分组效果。
2. 优化性能多组实现的性能

**Version 1.0.1 2021年2月10日**
1. XYInfomationBaseViewController 底层新增面向section数据的API，快速根据数据创建内容
2. 优化自定义Cell的底层实现
3. 新增纯自定义个人中心页面 Demo

**Version 1.0.0 2021年2月5日**
1. 支持完全自定义cell，需同时指定 type = other ,且指定 customCellClass 为自定义cell 类名
2. 新增 item api, 可控制单cell背景色，是否展示分割线，title占比等
3. 优化 section 对象折叠/展示cell 底层逻辑
4. 新增更多自定义 cell 的 Demo。demo 采用更简洁的数据为王的加载方式，简洁，清晰 <br>
支付宝 - 【我的】-【设置】<br> 微信 - 【隐私设置】<br> 微博 - 【设置页面】

**Version 0.4.0 2020年3月4日**
1. 增加对 XYInfomationCell 样式自定义的支持，新增 title/value/placeholder 的颜色、字体设置接口
2. 增加 XYInfomationSection 中设置 separateColor 和 separateInset 支持

**Version 0.3.0 2020年1月12日**
1. 添加XYInfomationCell类型，新增inputTextView类型，可以更方便输入长串数据

**Version 0.2.0 2019年12月20日**
1. 完全移除 XYInfomationCell.xib，全部代码使用代码约束，有效避免手动约束和xib约束冲突问题

**Version 0.1.1 2019年12月8日**
1. 更新资源加载方式，使用内部bundle，避免资源冲突
2. 移除无用的 XYInfomationBaseViewController.xib 和 XYInfomationSection.xib 文件

**Version 0.1.0 2019年11月29日**
1. 基本功能完成。附有完整Demo

### 项目简介

年初为顺应政策，我司 App 中增加《个人所得税》模块，项目从提需求到上线只有一个月，期间产品UI和交互多次变化。其中各种录入监听，修改页面布局等。由于UI的交互和样式的不断改动<到上线都没有出 UI 图>，加上时间紧还要和后端联调接口，接口字段都以拼音命名，导致很多结构和逻辑混合到一起。结果就是代码虽然能用，但实际上已成了一坨，缺乏复用性，也无法移植，严重违背了封装的思想!

最近这段时间回顾之前代码，决定**抽取一些信息录入组件的共性，封装一组可移植的独立代码，统一解决一些常见信息录入功能**，所以本项目就诞生了。

### 此项目能做什么

此项目主旨为信息录入也兼顾信息展示功能，以 **"组"** 的样式展示，主要示例如下：

1.基本使用(以5条数据为例)

<image src="image/base_01.png" width=270 height=198/> <image src="image/base_02.png" width=270 height=198/> <image src="image/base_03.png" width=270 height=198/> <image src="image/base_04.png" width=270 height=198/> <image src="image/base_05.png" width=270 height=198/>

2.高级使用(简单交互如:个人中心页面、个人信息页面、设置页面)

此页面中以展示为主，有响应用户交互，具体可以下载 Demo 查看

<image src="image/user_center.png" width=270 height=536/> <image src="image/userInfo.png" width=270 height=536/> <image src="image/setting.png" width=270 height=536/>

3.综合使用示例(添加家庭成员信息 & **个人所得税页面**)

添加家庭成员页面，加入用户交互，监听用户录入自动填充生日

<image src="image/add_user_01.png" width=270 height=536/> <image src="image/add_user_02.png" width=270 height=536/> 

**个人所得税**是一个综合模块，包括「子女教育」「继续教育」「住房贷款」「住房租金」「大病医疗」「赡养老人」6个独立税种。每个页面都会收集用户的相关信息。每个页面均有不同的用户输入监听，根据用户输入信息动态填充信息、隐藏信息、调整信息等，示例如下，详情请下载 DEMO 可看

<image src="image/tax_01.png" width=270 height=536/> <image src="image/tax_02.png" width=270 height=536/> <image src="image/tax_03.png" width=270 height=536/> <image src="image/tax_04.png" width=270 height=536/> <image src="image/tax_05.png" width=270 height=536/> <image src="image/tax_06.png" width=270 height=536/>

4.自定义示例(几个独立仿写DEMO 支付宝-我的-设置 、微信-隐私设置 、 微博-设置 、个人中心页)

可以打开【支付宝/微信/微博】的相关页面来对比一下还原度。有兴趣可以看一下源码，支付宝页面相对复杂源码 130 行，微信、微博、个人中心页均为 30 行。 **之所以此DEMO源码较少，是因为 XYInfomationSection 核心在于写交互类表单，详见个人所得税DEMO**

<image src="image/alipay_01.png" width=270 height=584.3/> <image src="image/alipay_02.png" width=270 height=584.3/> <image src="image/wechat.png" width=270 height=584.3/> <image src="image/weibo.png" width=270 height=584.3/> <image src="image/personInfo.png" width=270 height=584.3/>

### XYInfomationSection 优势

本 Demo 中页面内容均仅基于 XYInfomationSection 组件，其主要优势

- 方便集成与使用，仅需 1.创建对象 2.赋值内容数据 3.监听回调 即可
- 提供 ViewController 基类，可子类化使用，个税页面均继承于 XYInfomationBaseViewController 基类，使用只需赋值内容，可更专心于业务逻辑
- 方便监听:可以方便监听某项录入内容，如监听证件类型、证件号码，动态加载用户出生日期。根据是否有配偶，可动态展示/隐藏配偶信息相关条目，等等
- XYInfomationSection 内条目可随意折叠，只需要折叠条目 index 即可，适应更多场景。
- 一键校验录入结果，自动按顺序检验并提示未填项目。校验规则可自行实现。
- UI 和 数据分离，仅需数据即可加载 UI，使用者可以仅关心业务代码
- 适应场景广，详见DEMO示例，可处理大量数据，详见个人所得税Demo

### 安装

项目内布局依赖 Masonry ，请务必保证项目中 Masonry 可用。

#### CocoaPods

更新你的本地仓库以同步最新版本

```
pod repo update
```
在你项目的Podfile中配置

```
pod 'XYInfomationSection'
```

#### 手动导入

请把 XYInfomationSection 文件夹拷贝到你的项目。

### 使用示例

- 单纯使用展示

```
/// 创建数据Model，代表一行数据
XYInfomationItem *item = [XYInfomationItem modelWithTitle:@"自定义标题" titleKey:@" " type:0 value:@"" placeholderValue:nil disableUserAction:YES];

/// 创建 XYInfomationSection 对象
XYInfomationSection *section = [XYInfomationSection new];

/// 赋值数据
section.dataArray = @[item];

/// 监听内部Cell点击
section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
    /// 处理cell点击事件
};
```

- 推荐使用 XYInfomationBaseViewController 的方法。面向数据构建页面，使用更简单

```
1. 创建自己的页面，继承自 XYInfomationBaseViewController
2. veiwDidLoad 方法中调用自身创建 content 方法

// OC 版本示例
@implementation WeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setContentWithData:[DataTool WeiBoData] itemConfig:nil sectionConfig:nil  sectionDistance:20 contentEdgeInsets:UIEdgeInsetsMake(20, 0, 20, 0) cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
    	// 处理cell点击事件
    }];   
}

// Swift 版本示例
class PersonInfoController: XYInfomationBaseViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let color: CGFloat = 0.95
        self.view.backgroundColor = UIColor(red: color, green: color, blue: color, alpha: 1)
        self.setContentWithData(DataTool.customData(), itemConfig: nil, sectionConfig: nil, sectionDistance: 10, contentEdgeInsets: .zero) { (index, cell) in
            // 这里处理cell点击事件
        }
    }
}

# 构造数据格式如下
+ (NSArray *)customData{
    NSArray *section1 = @[
        @{
            @"imageName": @"grade",
            @"title": @"更换头像",
            @"titleKey": @"",
            @"value": @"",
            @"type": @3,
            @"customCellClass": @"SectionDemo.PersonInfoHeaderCell",
            @"cellHeight": @215,
            @"valueCode": @"",
        }
    ];
    
    UIImage *image = [UIImage imageNamed:@"rightArraw_gray2"];
    NSArray *section2 = @[
        @{
            @"imageName": @"",
            @"title": @"企业名称",
            @"titleKey": @"",
            @"value": @"蚂蚁金服有限公司",
            @"type": @3,
            @"customCellClass": @"SectionDemo.PersonInfoCell",
            @"cellHeight": @115,
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        }];
	NSArray *array = @[section1,section2];
	return array;
}
```

- 使用自定义Cell

```
1. 创建自定义cell 继承自 XYInfomationCell
2. 实现 init 方法。并在内部构建自己的cell 子视图与布局.(Swift 需要实现 override init(frame: CGRect) 方法)
3. 重写 ’- setModel:‘ 方法, 根据model 数据来给cell子组件赋值。(Swfit 需要重写model属性的为计算属性，并监听didSet方法即可)

// OC 版本示例
@implementation XYCustomCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 这里创建 cell 的 subView
    }
    return self;
}

- (void)setModel:(XYInfomationItem *)model
{
    [super setModel:model];
    // 在这里给自己subView的内容赋值
}

// Swift 版本示例
class PersonInfoCell: XYInfomationCell {
    
    let titleLabel = UILabel()
    let descLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
                
        // init and setup subviews
    }
    
    override var model: XYInfomationItem{
        didSet{
        		
        		// 给内容赋值
            titleLabel.text = model.title
            descLabel.text = model.value
        }
    }
}
```

- 详情请查看Demo中对不同功能的具体实现


### 感谢

本 Demo 使用到的三方库如下，感谢作者开源

- Masonry
- FMDB
- IQKeyboardManager
- SVProgressHUD
- MJExtension

### 协议

本项目代码基于 MIT 开源协议，请在该协议框架下使用

### End

PS. 若使用过程中有任何问题，请issues我。 ^_^

