import 'dart:io';
import 'package:course_work/bloc/search_bloc.dart';
import 'package:course_work/cubit/about_film_cubit.dart';
import 'package:course_work/cubit/global_cubit.dart';
import 'package:course_work/cubit/lenta_cubit.dart';
import 'package:course_work/data/model/film.dart';
import 'package:course_work/data/repository/api/additional_film_api_repository.dart';
import 'package:course_work/data/repository/api/search_api_repository.dart';
import 'package:course_work/event/search_event.dart';
import 'package:course_work/state/lenta_state.dart';
import 'package:course_work/state/search_state.dart';
import 'package:course_work/view/about_film.dart';
import 'package:course_work/view/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:course_work/data/repository/api/lenta_api_repository.dart';
import 'package:course_work/data/repository/storage/favorite_film_repository.dart';
import 'package:course_work/view/lenta.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Routes {
  static final String popular = '/popular';
  static final String favorite = '/favorite';
  static final String findPage = '/find';
  static final String about_film = '/aboutFilm';
}

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
  FavoriteFilmRepository favoriteFilmRepository = FavoriteFilmRepository(db);
  AdditionalApiRepository additionalApiRepository = AdditionalApiRepository();
  LentaApiRepository lentaApiRepository = LentaApiRepository();
  SearchApiRepository searchApiRepository = SearchApiRepository();
  runApp(
    MyApp(
      favoriteFilmRepository,
      additionalApiRepository,
      lentaApiRepository,
      searchApiRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final FavoriteFilmRepository favoriteFilmRepository;
  final AdditionalApiRepository additionalApiRepository;
  final LentaApiRepository lentaApiRepository;
  final SearchApiRepository searchApiRepository;

  const MyApp(
    this.favoriteFilmRepository,
    this.additionalApiRepository,
    this.lentaApiRepository,
    this.searchApiRepository, {
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LentaCubit lentaCubit = LentaCubit(lentaApiRepository);
    lentaCubit.init(favoriteFilmRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (BuildContext build) => SearchBloc(searchApiRepository),
        ),
        BlocProvider<AboutFilmCubit>(
          create: (BuildContext build) =>
              AboutFilmCubit(additionalApiRepository),
        ),
        BlocProvider<LentaCubit>(create: (BuildContext build) => lentaCubit),
        BlocProvider<GlobalCubit> (create: (context) => GlobalCubit(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: Routes.popular,
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
        routes: {
          Routes.popular: (context) {
            var lenta = Lenta();
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      BlocBuilder<LentaCubit, LentaState>(
                        builder: (context, state) {
                          return Text(
                            state.isFaivorite ? "Избранные" : "Популярные",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.findPage);
                        },
                        child: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
                body: lenta,
              ),
            );
          },
          Routes.findPage: (context) {
            final TextEditingController textEditingController = TextEditingController();
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      return TextField(
                        controller: textEditingController,
                        onChanged: (value) {
                          print(value);
                          context.read<SearchBloc>().add(TextChanged(text: value));
                        },
                      );
                    },
                  ),
                ),
                body: Search(textEditingController),
              ),
            );
          },
          Routes.about_film: (context) => SafeArea(
            child: Scaffold(appBar: AppBar(), body: AboutFilm()),
          ),
        },
      ),
    );
  }
}
