import 'package:bm2_text_audio_app/screens/audio.dart';
import 'package:flutter/material.dart';
import 'package:bm2_text_audio_app/data/data.dart';

class TextsAudios extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: dataAudios.map((audio) => _getTile(audio, context)).toList()
        ).toList(),
      ),
    );
  }

  Widget _getTile(Map audio, BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Audio(audio: audio),
            ));
      },
      child: ListTile(
        title: Text(audio['title']),
        subtitle: Text(audio['subtitle']),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
