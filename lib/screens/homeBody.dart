import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:morsoom/api/call_api.dart';
class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var degree = "\u00B0";
  var tempData = "Please Wait...";
  var location = "Current Location";
  var search = "Search";
  var description = "Welcome";
  var today_image = "//cdn.weatherapi.com/weather/64x64/day/113.png";
  var longi,lati;
  TextEditingController textEditingController = TextEditingController();


  void getWeather() async {
    if (kDebugMode) {
      print("Praised");
    }
    if (kDebugMode) {
      print("We Get the Value from the User: ${textEditingController.text}");
    }

    var machine = WeatherInformationMachine();
    Map<String,dynamic> response = await machine.getDataWithCity(textEditingController.text);
    //if(response["cod"] == 200){
      double tempDegree = response['current']['temp_c'];
      setState(() {
        location = response["location"]["name"]+", "+response["location"]["country"];
        tempData = tempDegree.toStringAsPrecision(2);
        description = response['current']['condition']['text'];
        today_image = response['current']['condition']['icon'];

      });
   // }
    /*else {
      Fluttertoast.showToast(
      msg: response["message"],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black12,
      textColor: Colors.white,
      fontSize: 16.0
      );
    }*/


  }


  void loadData() async{
    var serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (kDebugMode) {
      print(serviceStatus);
    }


    LocationPermission locationPermission = await Geolocator.checkPermission();

    if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();

      if(locationPermission == LocationPermission.denied){
        if (kDebugMode) {
          print("permission denied");
        }
      } else if(locationPermission == LocationPermission.deniedForever){
        if (kDebugMode) {
          print("forget it. it's reject forever.");
        }
      } else {
        if (kDebugMode) {
          print("permission given");
        }
      }
    }else {
      if (kDebugMode) {
        print("Permission Hold");
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    longi = position.longitude.toStringAsFixed(2);
    lati = position.latitude.toStringAsFixed(2);
    print("Lon : " + longi);
    print("Lat : " + lati);

    var machine = WeatherInformationMachine();
    var response = await machine.getDataWithLongLat(longi, lati);

    //if(response["cod"] == 200){
      double tempDegree = response['current']['temp_c'];

      setState(() {
        tempData = tempDegree.toStringAsPrecision(2);
        location = response["location"]["name"] + ", " + response["location"]["country"];
        description = response['current']['condition']['text'];
        today_image = response['current']['condition']['icon'];
      });
    //}
    /*else {
      Fluttertoast.showToast(
          msg: response["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black12,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }*/


  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    backgroundColor: Colors.blue,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  final ButtonStyle accentFlatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    backgroundColor: Colors.black26,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Text(
              location,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
            Text(tempData.toString() + degree + "C",
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                  fontSize: 40,
                )),
            Image.network("http:"+today_image),
            Text(
              description,
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 30,),
            Center(
              //alignment: Alignment.center,
              //color: Colors.green,
              child:  Container(
                alignment: Alignment.center,
                //color: Colors.white,
                width: 200,
                child:  TextField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20
                  ),

                ),
              ),
            ),
            ElevatedButton(
                style: flatButtonStyle,
                onPressed: getWeather,
                child: Text(
              search,
              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            )),
            ElevatedButton(style:accentFlatButtonStyle,onPressed: loadData, child: const Text(
                "Get Current Location Temperature"
            )
            ),
          ],
        )
    );
  }
}
