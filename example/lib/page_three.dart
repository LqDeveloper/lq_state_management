import 'package:flutter/material.dart';
import 'package:lq_state_management/lq_state_management.dart';

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderStateBuilder(
      pageIndex: 2,
      create: (_) => PageThreeController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PageThree'),
        ),
        body: Center(
          child: TextButton(onPressed: () {}, child: const Text('PageThree')),
        ),
      ),
    );
  }
}

class PageThreeController extends BaseController {
  @override
  List<String> get shouldNotifyIds => [];

  @override
  void onAppear() {
    super.onAppear();
    print("PageThreeController - onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    print("PageThreeController - onDisappear");
  }

  @override
  void onPageIndexChanged(int from, int to) {
    super.onPageIndexChanged(from, to);
    print('PageThreeController --- from:$from --- to:$to');
  }

  // @override
  // void onLifecycleChanged(LifecycleState state) {
  //   super.onLifecycleChanged(state);
  //   print("PageThreeController - $state");
  // }
}
