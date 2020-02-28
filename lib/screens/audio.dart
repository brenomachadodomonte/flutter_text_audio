import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

typedef void OnError(Exception exception);

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
  bool autoReplay = false;
  _AudioState(this.audio);

  Language language = Language.en;

  String audioPath;

  Duration _duration = Duration();
  Duration _position = Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  PlayerState state;

  @override
  void initState() {
    super.initState();
    setState(() {
      audioPath = audio['audios'][0]['path'];
      state = PlayerState.stopped;
    });
    initPlayer();
  }

  void initPlayer(){
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });

    advancedPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });

    advancedPlayer.completionHandler = () => setState((){
      if(autoReplay){
        _play();
      } else {
        state = PlayerState.stopped;
      }
    });
  }

  _play() {
    setState(() {
      audioCache.play(audioPath);
      state = PlayerState.playing;
    });
  }

  _stop() {
    setState(() {
      advancedPlayer.stop();
      state = PlayerState.stopped;
      _position = Duration();
    });
  }

  _pause(){
    setState(() {
      advancedPlayer.pause();
      state = PlayerState.paused;
    });
  }

  _resume(){
    setState(() {
      advancedPlayer.resume();
      state = PlayerState.playing;
    });
  }


  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${audio['title']} - ${audio['subtitle']}"),
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
              padding: EdgeInsets.fromLTRB(5, 10, 5, 15),
              alignment: Alignment.bottomCenter,
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Icon(Icons.stop, color: Colors.blue, size: 30,),
                          onTap: _stop,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton(
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          child: Icon(state != PlayerState.playing ? Icons.play_arrow : Icons.pause, color: Colors.white,),
                          onPressed: () {
                            switch(state){
                              case PlayerState.stopped: _play(); break;
                              case PlayerState.paused: _resume(); break;
                              case PlayerState.playing: _pause(); break;
                            }
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
                          ),
                          child: Slider(
                            value: _position.inSeconds.toDouble(),
                            onChanged: (double value) {
                              setState(() {
                                seekToSecond(value.toInt());
                                value = value;
                              });
                            },
                            min: 0.0,
                            max: _duration.inSeconds.toDouble(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Icon(Icons.loop, color: autoReplay ? Colors.blue : Colors.grey,),
                          onTap: (){
                            setState(() {
                              autoReplay = !autoReplay;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: DropdownButton(
                          isExpanded: true,
                          value: this.audioPath,
                          items: mountSpeakers(),
                          underline: Container(),
                          //iconSize: 15,
                          iconEnabledColor: Colors.blue,
                          onChanged: (value) {
                            setState(() {
                              this.audioPath = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> mountSpeakers() {
    List<DropdownMenuItem<String>> itens = [];
    for(Map audio in audio['audios']){
      itens.add(DropdownMenuItem<String>(
        value: audio['path'],
        child: Text(audio['name'].toUpperCase(), style: TextStyle(fontSize: 14, color: Colors.blue)),
      ));
    }

    return itens;
  }
}
