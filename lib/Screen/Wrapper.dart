import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/AuthScreens/LoginScreen.dart';
import 'package:userapp/Screen/NavigationScreens/BaseScreen.dart';
import 'package:userapp/Screen/Splash/FirstExperience.dart';

class Wrapper extends ConsumerStatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final userProvider = ref.watch(userInfoProvider);
    // return BaseHomeWidget();
    //  spHepler.setPrefbool('IsVerified', true);
    bool val = spHepler.getPrefbool('IsVerified') ?? false;
    return (userProvider.isLogin && val)
        ? BaseHomeWidget()
        : FirstTimeExperienceScreen();
  }
}
