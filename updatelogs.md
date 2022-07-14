# XYInfomationSection

一组可自定义的表单组件 **XYInfomationSection**.

### 更新日志

**Version 1.3.2 2022年7月14日**
1. cell.item 扩展一个新 dict 扩展，用于弥补原来 obj 字段特定用途，不够用的问题
2. 性能优化，对于指定 bgImage 的 section 的调整判断逻辑，不再内部判断用户入参是否正确，此处的正确性由调用方负责

**Version 1.3.1 2022年6月26日**
1. 性能优化，自定义cell类型 customCellClass 属性改为调用方指定类，不再内部查类型

**Version 1.3.0 2021年8月3日**
1. XYInfomationBaseViewController 新增内嵌方法，支持将内容嵌入到原有的 viewController，从而无需影响原有的类继承结构

**Version 1.2.0 2021年7月31日**
1. 核心功能为新增长按可重新排序功能，新增相关 api
2. 支持自定义cell长按滑动样式。 提供cell长按排序完成后回到，可在回调中确定是否使用新排序。 提供直接移动内部cell的api，方便使用
3. 完整版 version 1.2.0 版本文档： [v1.2.0 文档](doc/v1.2.0.md)
4. 新增支持长按滑动的 Demo 与截图

**Version 1.1.0 2021年5月19日**
1. 增加对设置功能支持，新增 XYInfomationTipCell/XYInfomationSwitchCell两种类型cell
2. XYInfoCellType 新增 XYInfoCellTypeTip/XYInfoCellTypeSwitch 可直接指定cell类型
3. 微信设置页面使用两种新 cell 部分重写。

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


