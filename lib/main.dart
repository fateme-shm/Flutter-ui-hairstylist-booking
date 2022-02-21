// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_field

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      tools: [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => MyApp(),
    ),
  );
}

/////////////// ********************************** /////////////////////
/////////////// ********************************** /////////////////////
/////////////// ********************************** /////////////////////
/////////////////////// Fateme Shamohammadi ////////////////////////////
/////////////// ********************************** /////////////////////
/////////////// ********************************** /////////////////////
/////////////// ********************************** /////////////////////

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pie Chart',
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainClass(),
      },
    );
  }
}

class MainClass extends StatefulWidget {
  @override
  _MainClassState createState() => _MainClassState();
}

class _MainClassState extends State<MainClass> {
  late ConfettiController _confettiController;
  double valuePass = 0.0, valueNotPass = 0.0;
  int progressValue = 0;

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void initState() {
    super.initState();
    valuePass = 0.1;
    valueNotPass = 0.9;
    progressValue = (valueNotPass * 100).ceil();
    _confettiController = ConfettiController(duration: Duration(seconds: 10));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _confettiController.play();
    return Container(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                colors: [
                  Colors.green,
                  Colors.black,
                  Colors.blue,
                  Colors.pink,
                  Colors.purple,
                  Colors.cyan,
                  Colors.brown,
                  Colors.indigo,
                  Colors.orange,
                  Colors.white,
                  Colors.yellow,
                ],
                createParticlePath: drawStar,
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return SweepGradient(
                        startAngle: 0.0,
                        endAngle: 3.14 * 2,
                        stops: [valueNotPass, valuePass],
                        center: Alignment.center,
                        colors: [
                          Colors.indigo,
                          Colors.transparent,
                        ],
                      ).createShader(rect);
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              progressValue.toString() + " %",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '19 of 20',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You are Awesome',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Congratulations for getting all',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'the answers correct',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.indigo[400],
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.message,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.blue[400],
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      LineAwesomeIcons.envelope,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.indigo[700],
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      LineAwesomeIcons.facebook_f,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.blue,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      LineAwesomeIcons.twitter,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
