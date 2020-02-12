import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

class Audio extends StatefulWidget {

  final Map audio;

  Audio({Key key, @required this.audio}) : super(key: key);

  @override
  _AudioState createState() => _AudioState(audio);
}

enum PlayerState { stopped, playing, paused }

class _AudioState extends State<Audio> {

  final Map audio;
  double fontSize = 24.0;
  _AudioState(this.audio);

  AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${audio['title']} - ${audio['subtitle']}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context)
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: (){}
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Text(audio['en_text'], style: TextStyle(fontSize: fontSize))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Text('A-', style: TextStyle(fontSize: 18),),
                    onPressed: (){
                      setState(() {
                        fontSize -= 2;
                      });
                    },
                  ),
                  FlatButton(
                    child: Text('A+', style: TextStyle(fontSize: 18),),
                    onPressed: (){
                      setState(() {
                        fontSize += 2;
                      });
                    },
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
