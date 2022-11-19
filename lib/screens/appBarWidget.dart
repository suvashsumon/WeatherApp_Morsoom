import 'package:flutter/material.dart';

class AppBatWidget extends StatefulWidget {
  const AppBatWidget({Key? key}) : super(key: key);

  @override
  State<AppBatWidget> createState() => _AppBatWidgetState();
}

class _AppBatWidgetState extends State<AppBatWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.topLeft,
      child:  const Text(
        "Weather",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}