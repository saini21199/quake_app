import 'package:earthqauke_app/models/earthquake.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earthquake'),
      ),
      body: FutureBuilder(
        future: fetchEarthquakes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Container(
                      width: 50.0,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent, shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        '${snapshot.data[index].mag}',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ))),
                  title: Text(snapshot.data[index].place),
                  subtitle: Text(
                      '${DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].time)}'),
                  onTap: () async {
                    final url =
                        'https://www.google.com/maps/search/?api=1&query=${snapshot.data[index].lattitude},${snapshot.data[index].longitude}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
