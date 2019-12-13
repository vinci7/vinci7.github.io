---
layout: post
title: 小程序排坑，bindtap传参时，参数时有时无的问题
category: 技术
category-visible: false
comments:
  - author:
      type: github
      displayName: vinci7
      url: 'https://github.com/vinci7'
      picture: 'https://avatars1.githubusercontent.com/u/3354532?v=4&s=73'
    content: >
      jekyll&#x5BF9;&#x4EE3;&#x7801;&#x4E2D;&#x7684;&#x53CC;&#x62EC;&#x53F7;&#x4E0D;&#x80FD;&#x5F88;&#x597D;&#x5730;&#x652F;&#x6301;&#xFF0C;&#x4F1A;&#x5F53;&#x505A;&#x8BED;&#x6CD5;&#x4E32;&#x5904;&#x7406;&#xFF0C;&#x5728;&#x8BE5;&#x573A;&#x666F;&#x4E0B;&#x4F1A;&#x88AB;&#x5904;&#x7406;&#x6210;&#x7A7A;&#x4E32;&#xFF0C;&#x56E0;&#x6B64;&#x52A0;&#x4E86;&#x4E11;&#x964B;&#x7684;&#x8F6C;&#x4E49;&#x5B57;&#x7B26;&#x4F5C;&#x4E3A;&#x6682;&#x65F6;&#x89E3;&#x51B3;&#x65B9;&#x6848;&#x3002;
    date: 2018-03-21T22:10:56.652Z

---

bindtap事件进行参数传递的问题，微信小程序官方文档提供了如下[示例](https://mp.weixin.qq.com/debug/wxadoc/dev/framework/view/wxml/event.html)：


```html
<view data-alpha-beta="1" data-alphaBeta="2" bindtap="bindViewTap"> DataSet Test </view>
 
Page({
  bindViewTap:function(event){
    event.target.dataset.alphaBeta == 1 // - 会转为驼峰写法
    event.target.dataset.alphabeta == 2 // 大写会转为小写
  }
})
```

wx:for列表渲染，官方[示例](https://mp.weixin.qq.com/debug/wxadoc/dev/framework/view/wxml/list.html)如下：

```html
<view wx:for="\{\{array\}\}">
  \{\{index\}\}: \{\{item.message\}\}
</view>
```

如果bindtap传参时，顺便使用了wx:for列表渲染

```html
<view wx:for="\{\{array\}\}" data-id="item.id" bindtap="getId">
  \{\{index\}\}: \{\{item.message\}\}
</view>
```

此时触发view的tap事件，会出现event.target.dataset.id获取时有时无的情况。
![](http://7xoc7e.com1.z0.glb.clouddn.com/18-3-22/20291582.jpg)

解决方案：

```html
<view wx:for="\{\{array\}\}">
  <view data-id="item.id" bindtap="getId">
	  \{\{index\}\}: \{\{item.message\}\}
  </view>
</view>
```


