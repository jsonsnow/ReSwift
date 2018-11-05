### 基于Reswift和App Coordinator架构学习

#### iOS应用开发复杂度

##### 1.复杂界面设计的实现和样式管理
复杂本质上是UI组件自身设计实现的复杂性，多UI组件之间组合方式和UI组件的重用机制

##### 2.路由设计
这儿的复杂性主要是UI和业务之间绕不清的互相耦合

##### 3.应用状态管理
一个iOS应用本质上就是一个状态机，从一个状态的UI由User Action或API调用返回的Data Action 触发达到下一个状态的UI，为了准确的控制应用的功能，开发者需要能够清楚的知道：

* 应用的当前UI是由哪些状态决定的？
* User Action会影响哪些应用状态？如何影响的？
* Data Action会影响哪些应用状态？如何影响的？

这儿的复杂性主要体现在治理分散的状态，以及管理不统一的状态改变机制带来的复杂性

#### 如何管理这些复杂度
从架构层面上应该如何去管理这些复杂性

##### 使用Atomic Design和Component Driven Development管理界面开发的复杂度

UI界面的复杂度本质上是一个点的复杂度，其复杂性集中在系统的某些小细节，不会增加系统整体规划的复杂度，所以控制其复杂度的主要方式是隔离，避免一个UI组件之间的相互交织，变成一个面上的复杂度，导致复杂度不可控制，在UI层，最流行的隔离方式就是组件化。

##### 使用App Coordinator统一管理应用路由

应用的路由主要分为App间路由和App内路由，对它们需要分别处理

**App间路由**
对APP之间的路由，主要是通过两种方式实现：

URL Scheme 

```
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool

```
转化App内路由

另一种是Universal Links，
在Appdelegate

```
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool

```
中转化为App内路由

App间的路由逻辑相对简单，就是把一个外部URL映射到内部路由中，这部分只需要增加一个URL Scheme或Universal Link对应到App内部路由的逻辑即可。

##### App内路由
对于内部路由，我们可以引入App Coordinator来管理所有路由，其核心理念如下：

* 1.抽象出一个Coordinator对象概念
* 2.由该Coordinator对象负责ViewController的创建和配置
* 3.由该Coordinator对象来管理所有的ViewController跳转
* 4.Coordinator可以派生子Coordinator来管理不同的Feature Flow

经过这一层抽象之后，应用的UI和业务逻辑被清晰的拆分，各自有了自己的清晰的职责。ViewController的初始化，ViewController之间的链接逻辑全部都转移到App Coordinator的体系中去了。
ViewController则彻底改变成了一个个独立的个体，其只负责：

1. 自己界面内子UIView的组织
2. 接收数据并且把数据绑定到对应的子UIView展示
3. 把界面的User Action转换为业务上的User intents,然后转入App Coordinator中进行业务处理

通过引入AppCoordinator之后，UI和业务逻辑被拆分，各自处理自己负责的逻辑.在iOS应用中，路由的底层实现还是UINavigationController提供的present,push,pop等函数，在其之上，iOS社区社区有JLRoutes,routable-ios,MGJRouter等。App Coordinator，其核心概念是把ViewController跳转和业务逻辑一起抽象为user intents，对于开发者具体使用什么样的方式实现的跳转逻辑并没有限制，而路由，路由的实现方式在一个应用中的影响范围非常广，切换路由的实现方式基本上就是一次全App的重构，可以再App Coordinator的基础上，还可以引入Protocol-Oriented Programming的概念，在App Coordinator的具体实现和ViewController之间抽象一层Protocos,把UI和业务逻辑的实现彻底彻底隔离。

优点

1. ViewController变得非常简单，成为了一个概念清晰的，独立的UI组件，这极大的增加了其可复用性。
2. UI和业务逻辑的抽离也增加了业务代码的可复用性，在多屏时代，当你需要为应用增加一个Ipad版本时，只需要重新做一套iPad UI对接到当前iPhone版本的App Coordinator中就完成了。
3. App Coordinator定义与实现的分离，UI和业务的分离让应用在做A/B Testing时候变得更加容易，可以简单的 **s使用不同实现的Coordinator**, 或者不同版本的ViewController即可。

#### 使用ReSwift应用管理状态
引入App Coordinator之后，ViewController的剩下的职责之一就是接受数据并把数据绑定到对应的子UIView展示。数据就是应用状态，ReSwift这套机制主要有以下几个概念：

1. App State：在一个时间上，应用的所有状态，只要App State一样，应用展现的就是一样的
2. Store: 保存App State的对象，其还负责发送Action更新App State
3. Action: 表示一次改变应用状态的行为，其本身可以携带用以改变App state的数据
4. Reducer:一个接收当前App state和Action,返回新的App state的小函数


#### Reswift缓存处理
缓存让reducer去考虑，store只是从reducers中拿数据，然后放到内存里，本事没有任何业务逻辑。

业务数据一般保存在具体的state中，action描述了如何更改state并携带相关数据。






