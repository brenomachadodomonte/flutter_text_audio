import 'package:flutter/material.dart';
import 'package:bm2_text_audio_app/screens/audio.dart';
import 'package:bm2_text_audio_app/data/data.dart';

class Home extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Texts & Audios'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: ListTile.divideTiles(
              context: context,
              tiles: dataAudios.map((audio) => _getTile(audio, context)).toList()
          ).toList(),
        ),
      ),
    );
  }
}
