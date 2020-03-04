import 'package:flutter/material.dart';
import 'package:bm2_text_audio_app/data/data.dart';

class Sentences extends StatefulWidget {
  @override
  _SentencesState createState() => _SentencesState();
}

class _SentencesState extends State<Sentences> {
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
    return ListTile(
      leading: IconButton(
        onPressed: (){
          print(sentence['audio']);
        },
        icon: Icon(Icons.play_circle_filled),
      ),
      title: Text(sentence['sentence']),
      subtitle: Text(sentence['pronunciation']),
    );
  }
}