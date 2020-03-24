import 'package:flutter/material.dart';
import 'package:bm2_text_audio_app/data/data.dart';
import 'package:bm2_text_audio_app/screens/pronunciation.dart';

class Pronunciations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: dataPronunciations.map((pronunciation) => _getTile(pronunciation, context)).toList()
        ).toList(),
      ),
    );
  }

  Widget _getTile(Map pronunciation, BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Pronunciation(pronunciation: pronunciation),
            ));
      },
      child: ListTile(
        title: Text(pronunciation['title']),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
