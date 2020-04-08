import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bm2_text_audio_app/widgets/painter.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Sentence extends StatefulWidget {

  final Map sentence;

  Sentence({Key key, @required this.sentence}) : super(key: key);

  @override
  _SentenceState createState() => _SentenceState();
}

class _SentenceState extends State<Sentence> with TickerProviderStateMixin {
  AnimationController controller;
  bool isPlaying = false;
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  String get timerString {
    Duration duration = controller.duration * (controller.value == 0.0 ? 1 : controller.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 10),
    );
    controller.addStatusListener((status){
      if(status == AnimationStatus.dismissed){
        setState(() {
          isPlaying = false;
        });
      }
    });
    initPlayer();
  }

  @override
  void dispose() {
    advancedPlayer.stop();
    advancedPlayer = null;
    audioCache = null;
    super.dispose();
  }

  void initPlayer(){
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.completionHandler = () => setState((){
      if(isPlaying){
        _play();
      }
    });
  }

  _play() {
      audioCache.play(widget.sentence['audio']);
  }

  _stop() {
      advancedPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sentence"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              _stop();
              advancedPlayer = null;
              audioCache = null;
              Navigator.pop(context);
            }
        ),
        centerTitle: true,
      ),
      //backgroundColor: Colors.white,
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: FractionalOffset.center,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: CustomPaint(
                                  painter: Painter(
                                    animation: controller,
                                    backgroundColor: Colors.black12,
                                    color: Colors.blue,
                                  )),
                            ),
                            Align(
                              alignment: FractionalOffset.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Timer",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20.0,color: Colors.black54),
                                  ),
                                  Text(timerString,style: TextStyle(fontSize: 100.0,color: Colors.black54),),
                                  FlatButton(
                                    child: Text('RESET',style: TextStyle(fontSize: 20.0,color: Colors.black54),),
                                    onPressed: (){
                                      controller.reset();
                                      _stop();
                                      setState(() {
                                        isPlaying = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: FractionalOffset.center,
                      child: Column(
                        children: <Widget>[
                          Text(widget.sentence['sentence'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),textAlign: TextAlign.center,),
                          Text(widget.sentence['pronunciation'], style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
                          Divider(),
                          Text(widget.sentence['meaning'], textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "btn1",
                        child: Icon(Icons.settings),
                        onPressed: (){
                          _showDialogSetup(context);
                        },
                      ),
                      FloatingActionButton.extended(
                        heroTag: "btn2",
                        label: Text(isPlaying ? 'Pause' : 'Play'),
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: (){
                          if(controller.isAnimating) {
                            controller.stop();
                            _stop();
                          } else {
                            controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
                            _play();
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _showDialogSetup(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Setup'),
          ),
          content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.ms,
                    minuteInterval: 1,
                    secondInterval: 1,
                    initialTimerDuration: controller.duration,
                    onTimerDurationChanged: (Duration changedtimer) {
                      setState(() {
                        if(controller != null){
                          controller.duration = changedtimer;
                        }
                      });
                    },
                  ),
                  SizedBox(height: 10.0,),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          child: Text(
                            "CLOSE",
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
        );
      },
    );
  }
}