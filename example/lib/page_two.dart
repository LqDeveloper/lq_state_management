import 'package:flutter/material.dart';
import 'package:lq_state_management/lq_state_management.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderStateBuilder(
      pageIndex: 1,
      create: (_) => PageTwoController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PageTwo'),
        ),
        body: Center(
          child: TextButton(onPressed: () {}, child: const Text('PageTwo')),
        ),
      ),
    );
  }
}

class PageTwoController extends BaseController {
  @override
  List<String> get shouldNotifyIds => [];

  @override
  void onAppear() {
    super.onAppear();
    print("PageTwoController - onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    print("PageTwoController - onDisappear");
  }

  @override
  void onPageIndexChanged(int from, int to) {
    super.onPageIndexChanged(from, to);
    print('PageTwoController --- from:$from --- to:$to');
  }

  // @override
  // void onLifecycleChanged(LifecycleState state) {
  //   super.onLifecycleChanged(state);
  //   print("PageTwoController - $state");
  // }
}
