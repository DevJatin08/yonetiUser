import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/Constant/BackgroundDecoration.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/Wrapper.dart';

class SplashScreen extends ConsumerStatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool wrapper = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (_) => FirstTimeExperienceScreen()));
      setState(() {
        wrapper = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = ref.watch(userInfoProvider);
    final size = MediaQuery.of(context).size;
    Path toppath = Path();
    toppath.moveTo(-size.width * 0.1, size.height * 0.2);
    toppath.arcToPoint(Offset(size.width * 0.3, size.height * 0.05),
        radius: Radius.circular(100), clockwise: false, rotation: 0);
    Path bottomPath = Path();
    bottomPath.moveTo(size.width * 1.05, size.height * 0.9);
    bottomPath.arcToPoint(Offset(size.width * 0.65, size.height * 0.8),
        radius: Radius.circular(85), clockwise: false, rotation: 0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: wrapper
          ? Wrapper()
          : Container(
              decoration: splashDecoration,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: ShapePainter(color: Color(0xff72c3f1), path: toppath, strokwidth: 30),
                    child: Container(),
                  ),
                  CustomPaint(
                    painter:
                        ShapePainter(color: Color(0xff72c3f1), path: bottomPath, strokwidth: 30),
                    child: Container(),
                  ),
                  Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'YONETI',
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class ShapePainter extends CustomPainter {
  Path path;
  Color color;
  double? strokwidth;
  ShapePainter({required this.path, required this.color, this.strokwidth = 25});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokwidth!;

    canvas.drawPath(path, paint);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
