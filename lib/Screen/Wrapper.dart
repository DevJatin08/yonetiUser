import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/AuthScreens/LoginScreen.dart';
import 'package:userapp/Screen/NavigationScreens/BaseScreen.dart';

class Wrapper extends StatefulHookWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final userProvider = useProvider(userInfoProvider);
    // return BaseHomeWidget();
    return !userProvider.isLogin ? LoginScreen() : BaseHomeWidget();
  }
}
