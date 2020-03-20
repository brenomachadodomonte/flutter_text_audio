import 'package:bm2_text_audio_app/tabs/pronunciations.dart';
import 'package:flutter/material.dart';
import 'package:bm2_text_audio_app/tabs/texts_audios.dart';
import 'package:bm2_text_audio_app/tabs/sentences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();

  final GlobalKey<ScaffoldState> _scaffoldKey1 = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey3 = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey4 = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey5 = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey6 = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          key: _scaffoldKey1,
          body: TextsAudios(),
          drawer: HomeDrawer(_pageController),
          appBar: _appBar("Texts & Audios", _scaffoldKey1),
        ),
        Scaffold(
          key: _scaffoldKey2,
          body: Container(
            child: Center(
              child: Text('Coming soon!'),
            ),
          ),
          drawer: HomeDrawer(_pageController),
          appBar: _appBar("Flashcards", _scaffoldKey2),
        ),
        Scaffold(
          key: _scaffoldKey3,
          body: Sentences(),
          drawer: HomeDrawer(_pageController),
          appBar: _appBar("Sentences", _scaffoldKey3),
        ),
        Scaffold(
          key: _scaffoldKey5,
          body: Pronunciations(),
          drawer: HomeDrawer(_pageController),
          appBar: _appBar("Pronunciation", _scaffoldKey5),
        ),
        Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              print('create alerts');
            },
          ),
          key: _scaffoldKey4,
          body: Container(
            child: Center(
              child: Text('Coming soon!'),
            ),
          ),
          drawer: HomeDrawer(_pageController),
          appBar: _appBar("Alerts", _scaffoldKey4),
        ),
        Scaffold(
          key: _scaffoldKey6,
          body: Container(
            child: Center(
              child: Text('Coming soon!'),
            ),
          ),
          drawer: HomeDrawer(_pageController),
          appBar: _appBar("About", _scaffoldKey6),
        ),
      ],
    );
  }

  Widget _appBar(String title,GlobalKey<ScaffoldState> key){
    return AppBar(
      title: Text(title),
      leading: IconButton(
          icon: Icon(Icons.dehaze, color: Colors.white),
          onPressed: () => key.currentState.openDrawer()
      ),
      centerTitle: true,
    );
  }
}


class HomeDrawer extends StatelessWidget {

  final PageController pageController;

  HomeDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 150.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 30.0,
                      left: 0.0,
                      child: Text("Texts & Audios",
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Hello student,",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text('It\'s time to study english!',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.queue_music, "Texts & Audios", pageController, 0),
              DrawerTile(Icons.flash_on, "Flashcards", pageController, 1),
              DrawerTile(Icons.view_list, "Sentences", pageController, 2),
              DrawerTile(Icons.record_voice_over, "Pronunciation", pageController, 3),
              Divider(),
              DrawerTile(Icons.notifications_none, "Alerts", pageController, 4),
              DrawerTile(Icons.info_outline, "About", pageController, 5),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    height: 60.0,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                          size: 32.0,
                          color: Colors.grey[700],
                        ),
                        SizedBox(width: 32.0,),
                        Text(
                          "Exit",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[700],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: controller.page.round() == page ?
                Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page.round() == page ?
                  Theme.of(context).primaryColor : Colors.grey[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}