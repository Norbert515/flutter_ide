import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../generated/&gen_code.dart';

class WidgetVisualizer extends StatelessWidget {


  static const double DEVICE_WIDTH = 1370;
  static const double DEVICE_HEIGHT = 2534;

  static const double RATIO = 2534 / 1370;
  static const double REV_RATIO = 1370 / 2534;



  @override
  Widget build(BuildContext context) {

    /// 1.8496350364963 Y per X
    /// 739.85401459854 height
    ///
    /// X:140 Y:296 upper left hand corner
    /// X:1219 Y:296 upper right hand corner
    /// X:1219 Y:2215 lower right hand corner
    /// X:140 Y:2215 lower left hand corner
    ///
    /// Screen sizes:
    /// width: 1079, height: 1919
    ///
    return LayoutBuilder(
      builder: (context, constraints) {
        double targetWidth;
        double targetHeight;
        if(constraints.maxWidth * RATIO < constraints.maxHeight) {
          targetWidth = min(constraints.maxWidth, 400);
          targetHeight = targetWidth * RATIO;
        } else {
          targetHeight = min(constraints.maxHeight, 400 * RATIO);
          targetWidth = targetHeight * REV_RATIO;
        }
        double xToDeviceX = targetWidth / DEVICE_WIDTH;
        double yToDeviceY = targetHeight / DEVICE_HEIGHT;

        print(constraints.maxWidth);
        print(targetWidth);
        print(xToDeviceX);
        return Stack(
          children: <Widget>[
            //Image.asset("assets/device_frame.png", width: TARGET_WIDTH),
            Image.file(File("C:\\Users\\Norbert\\workspace\\flutter_ide\\ide\\assets\\device_frame.png"), width: targetWidth, height: targetHeight,),
            Positioned(
              left: 140 * xToDeviceX,
              top: 296 * yToDeviceY,
              child: Container(
                color: Colors.blue,
                width: 1079 * xToDeviceX,
                height: 1919 * yToDeviceY,
                child: $displayWidget(),
              )
            ),
          ],
        );
      }
    );
  }
}
