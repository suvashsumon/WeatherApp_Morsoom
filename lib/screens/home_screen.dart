import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morsoom/controller/global_controller.dart';
import 'package:morsoom/widgets/header_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController = Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(()=> globalController.checkLoading().isTrue? const Center(
          child: CircularProgressIndicator(),
        ): ListView(
      scrollDirection: Axis.vertical,
      children: [
        const SizedBox(
          height: 20,
        ),
        const HeaderWidget(),
      ],
    ),
      )
    ));
  }
}