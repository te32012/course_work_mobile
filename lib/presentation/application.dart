import 'dart:convert';

import 'package:course_work/controller/RESTController.dart';
import 'package:course_work/data/model/topFilmRequest.dart';
import 'package:course_work/presentation/popular.dart';
import 'package:course_work/presentation/search_error_film.dart';
import 'package:course_work/presentation/search_not_found.dart';
import 'package:course_work/presentation/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Routes {
  static String popular = '/popular';
  static String favorite = '/favorite';
  static String search_error_found = '/SearchErrorFound';
  static String search_not_found = '/searchNotFound';
  static String waiting = '/waiting';
}

final getPages = [
  GetPage(
    name: Routes.favorite,
    page: () => SafeArea(child: Scaffold(body: Text(""))),
  ),

  GetPage(
    name: Routes.popular,
    page: () => SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Популярные", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Icon(Icons.search),
            ],
          ),
        ),
        body: Popular()
        )
      ),
    ),
  

  GetPage(
    name: Routes.search_error_found,
    page: () => SafeArea(child: Scaffold(body: SearchErrorFound())),
  ),

  GetPage(
    name: Routes.search_not_found,
    page: () => SafeArea(child: Scaffold(body: SearchNotFound())),
  ),

  GetPage(
    name: Routes.waiting,
    page: () => SafeArea(child: Scaffold(body: Waiting())),
  ),
];

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: Routes.popular,
      getPages: getPages,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
      ),
    );
  }
}
