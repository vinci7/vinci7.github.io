---
title: 《Java应用技术》考点整理
layout: post
category: 技术
---

`By Cookie`

Java常识
---

1. **跨平台数据类型统一**
JVM对系统底层完成了封装，Java代码可以直接在JVM中运行，一次编译处处运行。
2. **Java代码编译执行的过程**
3. **Java和C++的比较**
4. **Java内存模型**
	1. 寄存器：对客户端程序员来说是透明的（编写程序的时候感受不到其存在。）
	2. 堆栈：我的理解就是栈，在主存中存放对象的引用，并维护声明周期
	3. 堆：在主存中存放所有对象
	4. 常量：一般写在程序代码内部
	5. 非RAM存储：分为流对象和持久化对象（其实是操统中的字符设备和块设备。）
5. **单根结构**
Java采用单根结构，Java世界中的万物继承自Object对象，C++中则不是。
单根结构的优势：
	* 所有对象都易于在堆上创建
	* 便于参数传递
	* 便于垃圾回收
	
6. **main()**

		public static void main(String[] args){
			...
		}

对象
---

1. **基本数据类型**
	* 确定每种基本数据类型的存储空间大小，不随机器硬件架构变化而变化。
	* 基本数据类型不像普通对象那样把引用存在栈中，对象实体存在堆中。而是直接把变量值存在栈中，更加高效。
![](http://7xoc7e.com1.z0.glb.clouddn.com/16-1-18/62444627.jpg)

2. **关键字**
![](http://7xoc7e.com1.z0.glb.clouddn.com/16-1-18/61132331.jpg)

3. **对象变量的意义**
用引用（reference）或句柄（handle）操纵对象

4. **对象变量的赋值**
	* 基本类型直接复制本值
	* String复制引用，但是赋新值的时候放弃之前的引用
	* 对象复制引用
	
5. **传递对象变量进函数**
	* 方法的基本组成部分有：名称、返回值、参数列表、方法体
	* 方法签名：方法名和参数列表的合称，用于唯一标示方法
	* 传递引用
	
6. **对象变量的比较**
	* == 和 != 比较两个对象变量是否指向同一个对象
	* equal 比较两个对象变量指向对象是否相等

7. **字符串的连接**
8. **带标号的break和continue**
9. **this**
	指代当前对象
10. **成员初始化**
	* 成员变量初始化的顺序取决于定义的先后顺序
	* 必要的时候才初始化静态变量，在该类的构造器执行之前进行
	* 类的构造器是隐式的静态方法

	![](http://7xoc7e.com1.z0.glb.clouddn.com/16-1-18/41810255.jpg)
	
11. 静态成员
	脱离于对象存在，归属于当前类，采用懒加载的机制，只有运行与类有关的操作时才初始化。
	
12. 数组：创建、赋值、对象数组
13. for-each循环：对象数组for-each

类
---

1. **package和CLASSPATH**
	* package 和 import关键字帮我们把全局名字空间分隔开，避免名称冲突问题。

	举例： Dog.java加载过程
	
	1. 定位Dog.class位置
	2. 载入Dog.class
	3. 在堆上分配Dog空间
	4. 存储空间清零，引用置为null
	5. 执行
2. **public class**
	
3. **单继承**
	* 通过继承共享成员变量和方法
	* 基类的构造器总是先执行
	* 如果没有声明构造器，则执行默认构造器
	* 如果声明了带参数的构造器，却没有生命不带参数的构造器，则报错
	
	哪些没有被继承？
	
	* 构造函数没有被继承，但是能被调用
	* 父类的任何成员变量都是会被子类继承下去的,这些继承下来的私有成员虽对子类来说不可见,但子类仍然可以用父类的函数操作他们
	
4. **super**
	使用super.test()的方式在继承类中调用父类的方法。
	
5. **继承和私有变量的关系**
	父类的任何成员变量都是会被子类继承下去的,这些继承下来的私有成员虽对子类来说不可见,但子类仍然可以用父类的函数操作他们
	
6. **默认动态绑定**
7. **final变量** - *常量*
	* 一个永不改变的编译时常量
	* 一个运行时被初始化的值，你不希望他被改变
	* 在对这个常量进行定义的时候，必须对其进行赋值
	* 一个既static又final的变量，只占据一段不能改变的存储空间（一般用大写表示）
	* private 是隐式的 final
	
8. **final方法和类**
	final方法
	1. 锁住方法，以防继承类修改，确保继承中使方法的行为保持不变，并且不会被覆盖。
	2. 效率
	
	final类
	1. 不希望他有子类，在继承树上，final为叶子节点（绝育）
	2. final类禁止继承，类中方法隐式指定为final
	
9. **abstract & interface**
	抽象类和抽象方法
	* 子类从父类（抽象类）创建的共同接口中导出
	* 抽象方法只声明，不实现
	* 包含抽象方法的类称为抽象类
	
	接口
	
	* 接口中所有的方法都是public
	* 接口中所有的数据成员都是public static final
	
			class ClassName implements interface{
				...
			}
	* 接口可以继承自接口，但是不能继承自类
	* 一个类可以实现一个或多个接口
	
10. 内部类 ?
	* 在类中定义类
	* 
	* 与外部类的关系
	* 匿名函数的语法
	
11. 枚举类 ?
	*
	
	
容器
---

1. List, Set和Map的区别
	* List 通过特定序列存储
		* 可以进化为ArrayList和LinkedList
	* Set 不允许有重复元素
		* 可以进化为HashSet和TreeSet
	* Map 键值对
		* 可以进化为HashMap和TreeMap	
		
	![](http://7xoc7e.com1.z0.glb.clouddn.com/16-1-18/4713126.jpg)
	
2. Iterator和for-each遍历
	Iterator迭代器
	
		public void listNotes(){
			Iterator<String> it = notes.interators();
			while (it.hasNext()){
				System.out.println(it.next());
			}
		}
	
	for-each遍历
	
		public voidlistNotes(){
			for(String note : notes){
				System.out.println(note);
			}
		}
		
3. 范型的使用

		Iterator<String> it = notes.interators();
	
	* 开始时候不检查类型
	* 提供给客户端程序员向编译器声明类型的方法，以此检查类型
	
4. 子类型范型和通配符

标准类库
---

1. import的意义
	* Java解释器负责引用文件的查找、装载和解释。
	* Java解释器运行过程如下：
		* 找出环境变量CLASSPATH
		* 把package名称中的原点替换成斜杠或反斜杠（根据操作系统决定），进入该目录
		* 根据类名查找.class文件
	* import static : 调用函数不需要写类名了
	
2. String类：不可写、常用函数、switch-case
	* 初始化后不可变
	* 常用函数：
		* s.compareTo(t)
		* s.compareToIgnoreCase(t)
	
	switch-case:
	
		switch(s){
			case "this":
			...
			break;
			
			case "that":
			...
			break;
		}
		
3. StringBuffer类
4. Random类

异常
---

1. throw-try-catch: Throwable, catch的匹配，万能catch
2. finally
3. throws：override的关系
	如果父类的构造函数要抛异常,子类必须都抛出来

IO
---

1. stream：只处理byte(字节文件)
2. Reader/Writer和stream的关系（文本文件）
3. DataInput/OutputStream（二进制文件）
4. 对象串行化

GUI
---

1. 部件、容器、布局管理器的关系
2. JFrame：pack()、setDefaultCloseOperation()
3. Graphics
4. 常见布局管理器的效用
5. 菜单的类
6. Swing的消息机制：Listener、Event、add/removeListener、线程通知
7. 常见部件
8. JTable与MVC模式

线程
---

1. 创建线程：Runnable、Thread
2. 线程控制：start()、sleep()、yield()
3. synchronized
4. wait()和notify()
5. 管道通信

RTTI
---

1. Class类：getClass()、.class、isIntance()
2. instanceof

socket和JDBC
---

1. Socket和ServerSocket
2. JDBC如何连接和查询
	三部曲
	1. DriverManager
	2. Connection
	3. Statement
	4. ResultSet
	
3. 事物处理和preparedStatement
	事务处理
	1. setAutoCommit()
	2. commit()
	3. rollback()
	
Lambda
---

1. Lambda
2. 容器的stream接口






