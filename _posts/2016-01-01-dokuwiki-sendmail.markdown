---
title: dokuwiki发送邮件失败问题的解决
layout: post
category: 技术
category-visible: false
public: false
---

dokuwiki是一款开源好用的wiki管理系统，不需要连接数据库，纯文件存放数据内容，安装后遇到的问题是注册用户收不到注册信息邮件。

研究发现原因在于服务器没有安装SMTP服务

![](http://7xoc7e.com1.z0.glb.clouddn.com/16-1-1/14271011.jpg)

解决方案也很简单，只需要安装sendmail服务并开启即可

![](http://7xoc7e.com1.z0.glb.clouddn.com/16-1-1/96854600.jpg)

安装成功后使用telnet命令查看smtp服务默认占据的25号端口联通情况

![](http://7xoc7e.com1.z0.glb.clouddn.com/16-1-1/25657124.jpg)

再次尝试发送邮件

![](http://7xoc7e.com1.z0.glb.clouddn.com/16-1-1/57610145.jpg)

发现可以正常发送




