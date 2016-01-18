---
title: Nodejs 学习笔记
layout: post
category: 技术
---

##接受参数传递
Express官网给出了获取参数的三种方法

1. Checks route params (req.params), ex: /user/:id
2. Checks query string params (req.query), ex: ?id=12
3. Checks urlencoded body params (req.body), ex: id=12

##RESTful API

* GET - 用于获取数据。
* PUT - 用于添加数据。
* DELETE - 用于删除数据。
* POST - 用于更新或添加数据。

##防止SQL注入

* mysql.escape()
* connection.escape()
* pool.escape()

例如
	
	var sql    = 'SELECT * FROM users WHERE id = ' + connection.escape(userId);

##SQL语句格式化输入

	var query = connection.query('SELECT ?? FROM ?? WHERE id = ?', [columns, 'users', userId], function(err, results) {
  // ...
	});




##参考资料

按照我看的顺序排序：

 [Express 官方中文文档](http://www.expressjs.com.cn/)

 [Nodejs RESTful API 简介](http://www.runoob.com/nodejs/nodejs-restful-api.html)

 [廖雪峰的Javascript基础语法](http://www.liaoxuefeng.com/wiki/001434446689867b27157e896e74d51a89c25cc8b43bdb3000)

 [nodejs-mysql模块的使用](https://github.com/felixge/node-mysql)

 *[理解Express框架](http://javascript.ruanyifeng.com/nodejs/express.html)

 *[理解Nodejs怎么就成了服务器了](http://anjia.github.io/2015/08/03/node_demo/)

 [Nodejs 详细教程](http://www.runoob.com/nodejs/nodejs-tutorial.html) 我还没看

大家有什么学习感想一起来编辑吧！

~~DISCUSSION~~


