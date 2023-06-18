# library_state_management

## 包含的类

1. LifecycleMixin是针对ChangeNotifier的混入，添加了局部更新和生命周期的逻辑

```dart
///路由path
String? get routeName => _routeName;

///路由传递过来的参数
Object? get arguments => _arguments;

///页面的pageIndex
int? get pageIndex => _pageIndex;

///当前页面是否显示
bool get hasAppeared => _hasAppeared;

 /// 对应 state 的initState
@protected
void onInit() {}

/// WidgetsBinding.instance.addPostFrameCallback
@protected
void onPostFrame() {}

///页面显示
@protected
void onAppear() {}

///页面不显示
@protected
void onDisappear() {}

///用于释放操作
@protected
@mustCallSuper
@override
void dispose();

  ```

## 使用

1. 使用ProviderStateBuilder或者ProxyStateBuilder包裹组件

```dart

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      ///需要添加路由监听
      navigatorObservers: [LifecycleRouteObserver.routeObserver],
      home: const HomePage(),
    );
  }
}
```

2. Controller 继承值BaseController,获取自己写个类继承自ChangeNotifier，然后混入LifecycleMixin

```dart
/// 1.注册ID registerIds(['count']);
/// 2.可以通过notifySingleListener更新ID对应的组件或者notifyMultiListeners更新多个ID
/// 3.可以通过SelectorId监听事件或者 SelectorMultiId监听多个事件
class HomeController extends BaseController {
   int _count = 0;

   int get count => _count;

   set count(int value) {
      _count++;
      notifySingleListener('count');
   }
   /// 对应 state 的initState
   @override
   void onInit() {}
   
   ///在这个阶段获取路由传参，这个方法走后会走build方法，所以不需要再notify了
   @override
   void onContextReady(){}

   /// WidgetsBinding.instance.addPostFrameCallback
   @override
   void onPostFrame() {}

   ///页面显示
   @override
   void onAppear() {}

   ///页面不显示
   @override
   void onDisappear() {}

   ///AppLifecycleState.resumed
   /// App从后台进入前台
   @override
   void onResume() {}

   ///AppLifecycleState.paused
   /// App从前台进入后台
   @override
   void onPause() {}
}
```

3. 在组件中使用controller

```dart
class MyHome extends StatelessWidget {
   const MyHome({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Scaffold(
         appBar: AppBar(
            title: const Text('状态管理'),
         ),
         body: Center(
            //监听单个id
            // child: SelectorId<HomeController>(
            // id: 'count',
            //监听多个id
            child: SelectorMultiId<HomeController>(
               ids: ['count'],
               builder:
                       (BuildContext context, HomeController controller, Widget? child) {
                  return Text('当前的Count:${controller.count}');
               },
            ),
         ),
         floatingActionButton: FloatingActionButton(
            onPressed: () {
               //为了隐藏Proviider的context.read,这里定义了一readC方法
               context
                       .readC<HomeController>()
                       .count++;
            },
            child: const Icon(Icons.add),
         ),
      );
   }
}
```

## 针对PageView类型页面的使用

1. PageView外层需要用Scaffold或者ScrollNotificationObserver包裹
2. 设置pageIndex

```dart
class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderStateBuilder(
      create: (_) => PageOneController(),
      ///必须设置pageIndex
      pageIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PageOne'),
        ),
        body: Center(
          child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const PageFour()));
              },
              child: SelectorId<PageOneController>(
                  id: PageOneEvent.updateTime,
                  builder: (_, controller, __) {
                    return Text(controller.timeStr);
                  })),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

```