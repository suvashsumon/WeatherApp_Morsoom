import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morsoom/controller/global_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key:key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  final GlobalController globalController = Get.put(GlobalController(), permanent: true);
  String date = DateFormat("yMMMMd").format(DateTime.now());


  @override
  void initState() {
    getAddress(globalController.getLattitude().value, globalController.getLongitude().value);
    super.initState();
  }

  void getAddress(lat, lon) async{
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(city, style: const TextStyle(
            fontSize: 35,
          ),),
        ),
        Container(
          child: Text(date, style: const TextStyle(
            fontSize: 16,
          ),),
        )
      ],
    );
  }

}