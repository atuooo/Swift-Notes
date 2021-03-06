//: Questions

import Foundation

/*:
##### Self 的使用
请避免在Swift中使用self，因为我们不需要使用self来访问一个对象的属性或调用它的方法。

唯一需要使用的场景是在类或结构体的构造器中。你可以使用self来区分传入的参数和类/结构体的属性.
*/

/*:
##### 哪些情况下你不得不使用隐式拆包？说明原因。
1、对象属性在初始化的时候不能nil,否则不能被初始化。典型的例子是Interface Builder outlet类型的属性，它总是在它的拥有者初始化之后再初始化。在这种特定的情况下，假设它在Interface Builder中被正确的配置——outlet被使用之前，保证它不为nil。

2、[解决强引用的循环问题](ARC)——当两个实例对象相互引用，并且对引用的实例对象的值要求不能为nil时候。在这种情况下，引用的一方可以标记为unowned,另一方使用隐式拆包。

建议：除非必要，不要对option类型使用隐式拆包。使用不当会增加运行时崩溃的可能性。在某些情况下,崩溃可能是有意的行为,但有更好的方法来达到相同的结果,例如,通过使用fatalError( )函数
*/

/*:
##### 在Swfit中,什么时候用结构体，什么时候用类？
一直都有这样的争论：到底是用类的做法优于用结构体，还是用结构体的做法优于类。函数式编程倾向于值类型，面向对象编程更喜欢类。

在Swift 中，类和结构体有许多不同的特性。下面是两者不同的总结：

1. 类支持继承，结构体不支持。

2. 类是引用类型，结构体是值类型

3. 并没有通用的规则决定结构体和类哪一个更好用。一般的建议是使用最小的工具来完成你的目标，但是有一个好的经验是多使用结构体，除非你用了继承和引用语义。

注意：在运行时，结构体的在性能方面更优于类，原因是结构体的方法调用是静态绑定，而类的方法调用是动态实现的。这就是尽可能得使用结构体代替类的又一个好的原因。
*/

/*:
##### 对一个optional变量拆包有多少种方法？并在安全方面进行评价。
1. 强制拆包 ！操作符——不安全
2. 隐式拆包变量声明——大多数情况下不安全
3. 可选绑定——安全
4. 自判断链接（optional chaining）——安全
5. nil coalescing 运算符（空值合并运算符）——安全
6. Swift 2.0 的新特性 guard 语句——安全
7. Swift 2.0 的新特性optional pattern（可选模式） ——安全
*/

/*:
##### Swift 是面向对象编程语言还是函数式编程语言？
Swift是一种混合编程语言，它包含这两种编程模式。它实现了面向对象的三个基本原则:
- 封装
- 继承
- 多态

说道Swift作为一种函数式编程语言，我们就不得不说一下什么是函数式编程。有很多不同的方法去定义函数式编程语言，但是他们表达的意义相同。

最常见的定义来自维基百科：...它是一种编程规范…它把电脑运算当做数学函数计算，避免状态改变和数据改变。

很难说Swift是一个成熟的函数式语言，但是它已经具备了函数式语言的基础。
*/

/*:
##### 泛型协议
泛型协议 是通过typealias部分实现的。typealias不是一个泛型类型,它只是一个占位符的名字。它通常是作为关联类型被引用，只有协议被一个类型引用的时候它才被定义。
*/

/*:
const常量是一个在编译时或者编译解析时被初始化的变量。通过let创建的是一个运行时常量，是不可变得。它可以使用stattic 或者dynamic关键字来初始化。谨记它的的值只能被分配一次
*/

/*:
##### 你能通过extension(扩展)保存一个属性吗？请解释一下原因。

不能。扩展可以给当前的类型添加新的行为，但是不能改变本身的类型或者本身的接口。如果你添加一个新的可存储的属性，你需要额外的内存来存储新的值。扩展并不能实现这样的任务。
*/

/*:
##### 什么关键字可以实现递归枚举？
indirect 关键值可以允许递归枚举，代码如下：

enum List{
indirect case Cons(T, List)
}
*/

//: [Back](@Home)
