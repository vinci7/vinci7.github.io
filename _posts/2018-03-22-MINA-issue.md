---
layout: post
title: 小程序排坑，bindtap传参时，参数时有时无的问题
category: 技术
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
<view wx:for="{{array}}">
  {{index}}: {{item.message}}
</view>
```

如果bindtap传参时，顺便使用了wx:for列表渲染

```html
<view wx:for="{{array}}" data-id="item.id" bindtap="getId">
  {{index}}: {{item.message}}
</view>
```

此时触发view的tap事件，会出现event.target.dataset.id获取时有时无的情况。
![](http://7xoc7e.com1.z0.glb.clouddn.com/18-3-22/20291582.jpg)

解决方案：

```html
<view wx:for="{{array}}">
  <view data-id="item.id" bindtap="getId">
	  {{index}}: {{item.message}}
  </view>
</view>
```


