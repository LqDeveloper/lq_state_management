import 'package:example/page_two.dart';
import 'package:flutter/material.dart';
import 'package:lq_state_management/lq_state_management.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderStateBuilder(
      pageIndex: 0,
      create: (_) => PageOneController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PageOne'),
        ),
        body: Center(
          child: TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PageTwo()));
          }, child: const Text('PageOne')),
        ),
      ),
    );
  }
}

class PageOneController extends BaseController {
  @override
  List<String> get shouldNotifyIds => [];

  // @override
  // void onLifecycleChanged(LifecycleState state) {
  //   super.onLifecycleChanged(state);
  //   print("PageOneController - $state");
  // }

  @override
  void onAppear() {
    super.onAppear();
    print("PageOneController - onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    print("PageOneController - onDisappear");
  }

  @override
  void onPageIndexChanged(int from, int to) {
    super.onPageIndexChanged(from, to);
    print('PageOneController --- from:$from --- to:$to');
  }

  @override
  void onResume() {
    super.onResume();
    print("PageOneController - onResume");
  }

  @override
  void onPause() {
    super.onPause();
    print("PageOneController - onPause");
  }
}
