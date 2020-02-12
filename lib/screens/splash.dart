import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:bm2_text_audio_app/screens/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();

    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FadeTransition(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: animation,
              //duration: Duration(milliseconds: 1500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: Container(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(image: AssetImage('assets/images/splash.png'),),
                      Text('BM2', style: TextStyle(fontSize: 16, color: Colors.grey),),
                      Text('TEXTS & AUDIOS', style: TextStyle(fontSize: 26, color: Colors.grey),),
                    ],
                  )
              )
          )
      ),
    );
  }

}
