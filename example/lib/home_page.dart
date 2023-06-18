import 'package:example/page_one.dart';
import 'package:example/page_three.dart';
import 'package:example/page_two.dart';
import 'package:flutter/material.dart';
import 'package:lq_state_management/lq_state_management.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderStateBuilder(
      create: (_) => HomeController(),
      child: ScrollNotificationObserver(
        child: Scaffold(
          body: PageView(
            children: const [
              PageOne(),
              PageTwo(),
              PageThree(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeController extends BaseController {
  @override
  List<String> get shouldNotifyIds => [];

  // @override
  // void onInit() {
  //   super.onInit();
  //   print("HomeController - onInit");
  // }
  //
  // @override
  // void onPostFrame() {
  //   super.onPostFrame();
  //   print("HomeController - onPostFrame");
  // }
  //
  @override
  void onAppear() {
    super.onAppear();
    print("HomeController - onAppear");
  }

  @override
  void onDisappear() {
    super.onDisappear();
    print("HomeController - onDisappear");
  }

  // @override
  // void onResume() {
  //   super.onResume();
  //   print("HomeController - onResume");
  // }
  //
  // @override
  // void onPause() {
  //   super.onPause();
  //   print("HomeController - onResume");
  // }
  // @override
  // void onLifecycleChanged(LifecycleState state) {
  //   super.onLifecycleChanged(state);
  //   print("HomeController - $state");
  // }
}
