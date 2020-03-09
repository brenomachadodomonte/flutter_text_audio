import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:bm2_text_audio_app/data/data.dart';


enum PlayerState { stopped, playing }

class Sentences extends StatefulWidget {
  @override
  _SentencesState createState() => _SentencesState();
}

class _SentencesState extends State<Sentences> {

  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  PlayerState state;
  String audio;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    _stop('');
    advancedPlayer = null;
    audioCache = null;
    super.dispose();
  }

  void initPlayer(){
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.completionHandler = () => setState((){
      if(audio != null){
        _play(audio);
      }
    });
  }

  _play(String audioPath) {
    print('play');
    setState(() {
      if(state == PlayerState.playing){
        advancedPlayer.stop();
      }
      audio = audioPath;
      audioCache.play(audio);
      state = PlayerState.playing;
    });
  }

  _stop(String audioPath) {
    setState(() {
      audio = null;
      advancedPlayer.stop();
      state = PlayerState.stopped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: dataSentences.map((sentence) => _getTile(sentence)).toList()
        ).toList(),
      ),
    );
  }

  Widget _getTile(Map sentence){
    return MyTile(sentence: sentence, playAction: _play, stopAction: _stop);
  }
}


class MyTile extends StatefulWidget {

  final Map sentence;
  final ValueChanged<String> playAction;
  final ValueChanged<String> stopAction;

  MyTile({Key key, @required this.sentence, @required this.playAction, @required this.stopAction}) : super(key: key);

  @override
  _MyTaleState createState() => _MyTaleState(sentence);
}

class _MyTaleState extends State<MyTile> {

  bool playing = false;
  final Map sentence;

  _MyTaleState(this.sentence);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: (){
          setState(() {
            if(playing){
              widget.stopAction(sentence['audio']);
            } else {
              widget.playAction(sentence['audio']);
            }
            playing = !playing;
          });
        },
        icon: Icon(playing ? Icons.stop : Icons.play_arrow, color: playing ? Colors.blue[300] : Colors.black54),
      ),
      title: Text(sentence['sentence'], style: TextStyle(color: playing ? Colors.blue : Colors.black),),
      subtitle: Text(sentence['pronunciation'], style: TextStyle(color: playing ? Colors.blue[300] : Colors.black54),),
    );
  }
}
