import 'package:flutter/widgets.dart';

BoxDecoration splashDecoration = BoxDecoration(
  gradient: LinearGradient(
      colors: [
        const Color(0xFF4fc3f7),
        const Color(0xff3949ab),
      ],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(0.5, 1),
      stops: [0.2, 1.0],
      tileMode: TileMode.clamp),
);
