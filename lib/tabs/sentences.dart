import 'package:bm2_text_audio_app/screens/sentence.dart';
import 'package:flutter/material.dart';
import 'package:bm2_text_audio_app/data/data.dart';

class Sentences extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: dataSentences.map((sentence) => _getTile(sentence, context))
                .toList()
        ).toList(),
      ),
    );
  }

  Widget _getTile(Map sentence, BuildContext context) {
    return ListTile(
      title: Text(sentence['sentence']),
      subtitle: Text(sentence['pronunciation']),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Sentence(sentence: sentence),
            ));
      },
    );
  }
}