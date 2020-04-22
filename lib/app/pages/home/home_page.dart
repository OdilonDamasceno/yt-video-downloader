import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yt_video_downloader/app/pages/home/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _urlController = new TextEditingController();
  final _homeController = new HomeController();
  Future info;
  Widget _widget = Container();
  List<DropdownMenuItem<String>> _items = [
    DropdownMenuItem(
      child: Text('Video'),
      value: '0',
    ),
    DropdownMenuItem(
      child: Text('Audio'),
      value: '1',
    ),
  ];
  var _value = '0';

  getInfo() {
    setState(() {
      info = _homeController.getInfo('${_urlController.text}');
      _widget = CircularProgressIndicator();
    });
  }

  getData() async {
    _value == '0'
        ? await _homeController.downloadVideo(_urlController.text)
        : await _homeController.downloadAudio(_urlController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Youtube video downloader',
          style: TextStyle(color: Theme.of(context).backgroundColor),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: ListView(
        primary: false,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _urlController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        labelText: 'URL',
                        hintText: 'Ex: http://youtu.be/Kj4jc82x',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: DropdownButton<String>(
                      itemHeight: 75,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                      value: _value,
                      items: _items,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: info,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = json.decode(snapshot.data.toString());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              data['tumbnails'][data['tumbnails'].length - 1]
                                  ['url'],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data['title'],
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              data['author_avatar'],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(data['author']),
                        ],
                      ),
                      FlatButton(
                        child: Text(
                          'Continue Download',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 17,
                          ),
                        ),
                        onPressed: getData,
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: _widget);
              }
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        child: FloatingActionButton(
          isExtended: true,
          onPressed: getInfo,
          child: Text(
            'Continue',
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
        ),
      ),
    );
  }
}
