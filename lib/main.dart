import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glbglbb_app/const.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool apphasStart = false;
  double ballX = 0;
  double velocityValue = 0;
  double accelValue = 0;

  void startTimer() {
    apphasStart = true;
    Timer.periodic(Duration(milliseconds: 10), (Timer) {
      updateVelocity();
      updateAccel();
    });
  }

  void updateVelocity() {
    setState(() {
      ballX += velocityValue / 200;
      if (ballX > 1.3) {
        ballX = -1.3;
      } else if (ballX < -1.3) {
        ballX = 1.3;
      }
    });
  }

  void updateAccel() {
    setState(() {
      velocityValue += accelValue / 200.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (apphasStart == false) {
      startTimer();
    }
    return Scaffold(
      backgroundColor: Color(0xff22577A),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height(context) * .1,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text('Simulator GLB - GLBB',
                        style: GoogleFonts.poppins(
                            fontSize: 30, color: Color(0xff57CC99))),
                  ),
                  Container(
                    child: Text(
                      'by Falah',
                      style: GoogleFonts.ubuntu(
                          fontSize: 20, color: Color(0xff57CC99)),
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: height(context) * .51,
                width: width(context),
                child: Container(
                  alignment: Alignment(ballX, 0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff63B4B8)),
                  ),
                )),
            Column(
              children: [
                Text(
                  'Kecepatan (v) = ' + velocityValue.round().toString(),
                  style: GoogleFonts.poppins(
                      color: Color(0xff57CC99), fontSize: 19),
                ),
                Container(
                  height: height(context) * .08,
                  child: Slider(
                      min: 0,
                      max: 10,
                      activeColor: Color(0xff7FC8A9),
                      inactiveColor: Color(0xff444941),
                      label: '$velocityValue',
                      value:
                          (velocityValue + 5) < 10 ? (velocityValue + 5) : 10,
                      onChanged: (double value) {
                        setState(() {
                          velocityValue = value - 5;
                        });
                      }),
                ),
                Container(
                  child: Text('K E C E P A T A N ',
                      style: GoogleFonts.ubuntu(color: Colors.white)),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 55),
              child: Column(
                children: [
                  Text('Percepatan (a) = ' + accelValue.round().toString(),
                      style: GoogleFonts.poppins(
                          color: Color(0xff57CC99), fontSize: 19)),
                  Container(
                    height: height(context) * .07,
                    width: width(context) * .4,
                    child: Slider(
                        min: -1,
                        max: 1,
                        activeColor: Color(0xff7FC8A9),
                        inactiveColor: Color(0xff444941),
                        divisions: 2,
                        label: '$accelValue',
                        value: accelValue,
                        onChanged: (double aValue) {
                          setState(() {
                            accelValue = aValue;
                          });
                        }),
                  ),
                  Container(
                    child: Text('P E R C E P A T A N',
                        style: GoogleFonts.ubuntu(color: Colors.white)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
