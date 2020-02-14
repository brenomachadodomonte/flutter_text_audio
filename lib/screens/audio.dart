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
  bool showText = true;
  _AudioState(this.audio);

  Language language = Language.en;

  AudioPlayer audioPlayer;

  //for tests
  double value = 5.0;
  int currentSpeaker = 0;

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
                      child: Icon(showText ? Icons.visibility_off : Icons.visibility, color: Colors.white,),
                      onPressed: (){
                        setState(() {
                          showText = !showText;
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
              flex: 4,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Opacity(
                        opacity: showText ? 1.0 : 0.0,
                        child: Text(language == Language.en ? audio['en_text'] : audio['pt_text'], style: TextStyle(fontSize: fontSize)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
              alignment: Alignment.bottomCenter,
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      child: Icon(Icons.play_arrow, color: Colors.white,),
                      onPressed: () {
                        print('PLAY VIDEO');
                      },
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Slider(
                      value: value,
                      onChanged: (double value) => {},
                      min: 0.0,
                      max: 10.0
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButton(
                      isExpanded: false,
                      value: currentSpeaker,
                      items: [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text('JAKE', style: TextStyle(fontSize: 14, color: Colors.blue),),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text('JOHN', style: TextStyle(fontSize: 14, color: Colors.blue)),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text('MOIRA', style: TextStyle(fontSize: 14, color: Colors.blue)),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text('NATALIE', style: TextStyle(fontSize: 14, color: Colors.blue)),
                        ),
                      ],
                      //iconSize: 15,
                      iconEnabledColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          this.currentSpeaker = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
