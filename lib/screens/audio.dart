import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

class Audio extends StatefulWidget {

  final Map audio;

  Audio({Key key, @required this.audio}) : super(key: key);

  @override
  _AudioState createState() => _AudioState(audio);
}

enum PlayerState { stopped, playing, paused }

enum Language { pt, en }

class _AudioState extends State<Audio> {

  final Map audio;
  double fontSize = 24.0;
  bool showTextConfigs = true;
  _AudioState(this.audio);

  Language language = Language.en;

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
            onPressed: (){
              setState(() {
                showTextConfigs = !showTextConfigs;
              });
            }
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: showTextConfigs,
              child: Container(
                color: Colors.blue[400],
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.visibility_off, color: Colors.white,),
                      onPressed: (){
                        setState(() {
                          fontSize -= 2;
                        });
                      },
                    ),
                    FlatButton(
                      child: Text(language == Language.en ? 'PT' : 'EN', style: TextStyle(fontSize: 14,color: Colors.white),),
                      onPressed: (){
                        setState(() {
                          language = language == Language.en ? Language.pt : Language.en;
                        });
                      },
                    ),
                    FlatButton(
                      child: Text('A-', style: TextStyle(fontSize: 14,color: Colors.white),),
                      onPressed: (){
                        setState(() {
                          fontSize -= 2;
                        });
                      },
                    ),
                    FlatButton(
                      child: Text('A+', style: TextStyle(fontSize: 14,color: Colors.white),),
                      onPressed: (){
                        setState(() {
                          fontSize += 2;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Text(language == Language.en ? audio['en_text'] : audio['pt_text'], style: TextStyle(fontSize: fontSize))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
