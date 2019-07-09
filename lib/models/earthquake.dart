import 'dart:convert';
import 'package:http/http.dart' as http;

class Earthquake {
  double mag;
  String place;
  int time;
  double longitude;
  double lattitude;
  double depth;

  Earthquake(
      {this.mag,
      this.place,
      this.time,
      this.longitude,
      this.lattitude,
      this.depth});

  factory Earthquake.fromJSON(Map json) {
    return Earthquake(
        mag: json['properties']['mag'].toDouble(),
        place: json['properties']['place'],
        time: json['properties']['time'],
        longitude: json['geometry']['coordinates'][0].toDouble(),
        lattitude: json['geometry']['coordinates'][1].toDouble(),
        depth: json['geometry']['coordinates'][2].toDouble());
  }
}

Future<List<Earthquake>> fetchEarthquakes() async {
  http.Response res = await http.get(
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson');
  if (res.statusCode == 200) {
    List<Map<String, dynamic>> maplist =
        json.decode(res.body)['features'].cast<Map<String, dynamic>>();
    List<Earthquake> list = maplist.map((Map json) {
      return Earthquake.fromJSON(json);
    }).toList();
    return list;
  } else {
    print('Data not found');
}
return  null;
}