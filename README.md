# SectionDemo

一组可自定义的表单组件 **XYInfomationSection**.

### 更新

**Version 1.0.0 2019年11月29日**
1. 基本功能完成。附有完整Demo

### 项目简介

年初为顺应政策，我司 App 中增加《个人所得税》模块，项目从提需求到上线只有一个月，期间产品UI和交互多次变化。其中各种录入监听，修改页面布局等。由于UI的交互和样式的不断改动<到上线都没有出 UI 图>，加上时间紧还要和后端联调接口，接口字段都以拼音命名，导致很多结构和逻辑混合到一起。结果就是代码虽然能用，但实际上已成了一坨，缺乏复用性，也无法移植，严重违背了封装的思想!

最近这段时间回顾之前代码，决定**抽取一些信息录入组件的共性，封装一组可移植的独立代码，统一解决一些常见信息录入功能**，所以本项目就诞生了。

### 此项目能做什么

此项目主旨为信息录入也兼顾信息展示功能，以 **"组"** 的样式展示，主要示例如下：

1.基本样式(以5条数据为例)

<image src="image/base_01.png" width=270 height=198/> <image src="image/base_02.png" width=270 height=198/> <image src="image/base_03.png" width=270 height=198/> <image src="image/base_04.png" width=270 height=198/> <image src="image/base_05.png" width=300 height=220/>

