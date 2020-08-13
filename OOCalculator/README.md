## 面向对象的思路实现一个计算器

既然说到了面向对象,那么我们就先来看看面向对象的三大特性：

### 封装

所谓封装，也就是把客观事物封装成抽象的类，并且类可以把自己的数据和方法只让可信的类或者对象操作，对不可信的进行信息隐藏。封装是面向对象的特征之一，是对象和类概念的主要特性。 简单的说，一个类就是一个封装了数据以及操作这些数据的代码的逻辑实体。在一个对象内部，某些代码或某些数据可以是私有的，不能被外界访问。通过这种方式，对象对内部数据提供了不同级别的保护，以防止程序中无关的部分意外的改变或错误的使用了对象的私有部分。

### 继承

所谓继承是指可以让某个类型的对象获得另一个类型的对象的属性的方法。它支持按级分类的概念。继承是指这样一种能力：它可以使用现有类的所有功能，并在无需重新编写原来的类的情况下对这些功能进行扩展。 通过继承创建的新类称为“子类”或“派生类”，被继承的类称为“基类”、“父类”或“超类”。继承的过程，就是从一般到特殊的过程。要实现继承，可以通过“继承”（Inheritance）和“组合”（Composition）来实现。继承概念的实现方式有二类：实现继承与接口继承。实现继承是指直接使用基类的属性和方法而无需额外编码的能力；接口继承是指仅使用属性和方法的名称、但是子类必须提供实现的能力；

 
### 多态

所谓多态就是指一个类实例的相同方法在不同情形有不同表现形式。多态机制使具有不同内部结构的对象可以共享相同的外部接口。这意味着，虽然针对不同对象的具体操作不同，但通过一个公共的类，它们（那些操作）可以通过相同的方式予以调用。



再来看看 面向对象的五大原则：

### 单一职责原则SRP(Single Responsibility Principle) 

是指一个类的功能要单一，不能包罗万象。如同一个人一样，分配的工作不能太多，否则一天到晚虽然忙忙碌碌的，但效率却高不起来。

### 开放封闭原则OCP(Open－Close Principle) 

一个模块在扩展性方面应该是开放的而在更改性方面应该是封闭的。比如：一个网络模块，原来只服务端功能，而现在要加入客户端功能，
那么应当在不用修改服务端功能代码的前提下，就能够增加客户端功能的实现代码，这要求在设计之初，就应当将服务端和客户端分开，公共部分抽象出来。

### 替换原则(the Liskov Substitution Principle LSP) 

子类应当可以替换父类并出现在父类能够出现的任何地方。比如：公司搞年度晚会，所有员工可以参加抽奖，那么不管是老员工还是新员工，
也不管是总部员工还是外派员工，都应当可以参加抽奖，否则这公司就不和谐了。

### 依赖原则(the Dependency Inversion Principle DIP)

具体依赖抽象，上层依赖下层。假设B是较A低的模块，但B需要使用到A的功能，
这个时候，B不应当直接使用A中的具体类： 而应当由B定义一抽象接口，并由A来实现这个抽象接口，B只使用这个抽象接口：这样就达到
了依赖倒置的目的，B也解除了对A的依赖，反过来是A依赖于B定义的抽象接口。通过上层模块难以避免依赖下层模块，假如B也直接依赖A的实现，那么就可能造成循环依赖。一个常见的问题就是编译A模块时需要直接包含到B模块的cpp文件，而编译B时同样要直接包含到A的cpp文件。

### 接口分离原则(the Interface Segregation Principle ISP) 

模块间要通过抽象接口隔离开，而不是通过具体的类强耦合起来


## 具体思路

如何利用继承和多态来实现我们的计算器的功能。

下面先看一下我设计的类的结构:

![](http://og0h689k8.bkt.clouddn.com/18-5-23/88577918.jpg)

一个基类: Operator
几个派生类: AddOperator/MinusOperator/MultiplyOperator/DivisionOperator


## 实现步骤

* 拿到一个四则运算的字符串之后,我们先根据正则表达式匹配出字符串中所有的运算符以及运算数并且分别存放在opts和nums两个数组中

* 比较opts中所有运算符的优先级,找到优先级最高的运算符并且在nums中找到对应的运算数 进行这次运算。得到运算记过之后将运算符从opts中删除 将运算数从nums中删除。

* 循环上面一步,一直到opts中为空时,说明已经计算完毕。nums中的值就是最终的计算结果。


## 继承和多态的运用

我们在创建operator的时候根据这个operator的值去分别创建不同的对象,然后调用的时候 会根据operator具体的类型来调用对应类的方法。

