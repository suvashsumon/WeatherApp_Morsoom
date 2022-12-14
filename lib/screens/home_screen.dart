import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morsoom/screens/appBarWidget.dart';
import 'package:morsoom/screens/homeBody.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: const AppBatWidget(),
      ),
      backgroundColor: Colors.white,
      body: const HomeBody(),


    );
  }
}