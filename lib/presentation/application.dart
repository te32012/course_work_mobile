import 'dart:io';
import 'package:course_work/data/model/film.dart';
import 'package:course_work/presentation/search.dart';
import 'package:path/path.dart';
import 'package:course_work/controller/rest_controller.dart';
import 'package:course_work/data/repository/favorite_film_repository.dart';
import 'package:course_work/data/repository/tmp_film_repository.dart';
import 'package:course_work/presentation/main.dart';
import 'package:course_work/presentation/search_error_film.dart';
import 'package:course_work/presentation/search_not_found.dart';
import 'package:course_work/presentation/waiting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Routes {
  static final String popular = '/popular';
  static final String favorite = '/favorite';
  static final String searchErrorFound = '/SearchErrorFound';
  static final String searchNotFound = '/searchNotFound';
  static final String waiting = '/waiting';
  static final String findPage = '/find';
}

final getPages = [
  GetPage(
    name: Routes.popular,
    page: () {
      var m = Main();
      var text = TextEditingController().obs;
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Obx(
                  () => Text(
                    m.controller.isFaivorite.value ? "Избранные" : "Популярные",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() {
                      return SafeArea(
                        child: Scaffold(
                          appBar: AppBar(
                            title: Obx(
                              () => TextField(
                                controller: text.value,
                                onChanged: (value) async {
                                  print(value);
                                  await Get.find<Restcontroller>().fetchPageByKeyword(value);
                                  Get.find<Restcontroller>().search.refresh();
                                },
                              ),
                            ),
                          ),
                          body: Search(text),
                        ),
                      );
                    });
                  },
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          body: m,
        ),
      );
    },
  ),

  GetPage(
    name: Routes.searchErrorFound,
    page: () => SafeArea(child: Scaffold(body: SearchErrorFound())),
  ),

  GetPage(
    name: Routes.searchNotFound,
    page: () => SafeArea(child: Scaffold(body: SearchNotFound())),
  ),

  GetPage(
    name: Routes.waiting,
    page: () => SafeArea(child: Scaffold(body: Waiting())),
  ),
];

Future<Directory> getDir() async {
  final dir = getApplicationDocumentsDirectory();
  return await dir;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getDir();
  print(dir.path);
  var db = await openDatabase(
    join(dir.path, 'film.db'),
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE films (id INTEGER PRIMARY KEY, idFilm INTEGER, data TEXT)',
      );
    },
    version: 1,
  );
  /*

  Restcontroller r =  Restcontroller(
      FavoriteFilmRepository(db).obs,
      TmpFilmRepository().obs,
      TmpFilmRepository().obs,
    );
  Film f = Film(filmId: 1, nameRu:  "noname", posterUrl:  "https://kinopoiskapiunofficial.tech/images/posters/kp/7527789.jpg");
  r.getImage(f);
  print(f.posterData);
  r.fetchPageByKeyword("балерина");
  print(r.search.value.films);
    */
  Get.put(
    Restcontroller(
      FavoriteFilmRepository(db).obs,
      TmpFilmRepository().obs,
      TmpFilmRepository().obs,
    ),
  );
  Get.find<Restcontroller>().storage.value.init();
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
        // try changing theeedColo sr in the colorScheme below to Colors.green
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
