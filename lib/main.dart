import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'Weather App',
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var name;

  Future getWeather() async {
    http.Response response = await http.get('http://api.openweathermap.org/data/2.5/weather?q=London&units=imperial&appid=0f976a350c52b32cd8a0c9b854538ebb');
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results["main"]["humidity"];
      this.windspeed = results['wind']['speed'];
      this.name = results['name'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text('Weather App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Colombo",
                    style: TextStyle(color: Colors.black, fontSize: 34.0, fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + '\u00B0' : 'Loading',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    currently != null ? currently.toString() : 'Loading',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.thermostat_outlined),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString() + '\u00B0' : 'Loading'),
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud),
                    title: Text('Description'),
                    trailing: Text(description != null ? description.toString() : 'Loading'),
                  ),
                  ListTile(
                    leading: Icon(Icons.wb_sunny),
                    title: Text('Humidity'),
                    trailing: Text(humidity != null ? humidity.toString() : 'Loading'),
                  ),
                  ListTile(
                    leading: Icon(Icons.speed),
                    title: Text("Wind Speed"),
                    trailing: Text(windspeed != null ? windspeed.toString() : 'Loading'),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}

