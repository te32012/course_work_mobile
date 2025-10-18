import 'dart:io';

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/model/repository/db_repo.dart';
import 'package:course_work/model/repository/films_repo.dart';
import 'package:course_work/view/screens/favourite_screen.dart';
import 'package:course_work/view/screens/popular_screen.dart';
import 'package:course_work/view/screens/search_screen.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/favorite_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/search_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/about_film_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/popular_cubit.dart';
import 'package:course_work/model/repository/http_repo.dart';
import 'package:course_work/view/screens/about_screen.dart';
import 'package:course_work/viewModel/service/db_service.dart';
import 'package:course_work/viewModel/service/film_service.dart';
import 'package:course_work/viewModel/service/http_service.dart';
import 'package:course_work/viewModel/usecase/about_films_uc.dart';
import 'package:course_work/viewModel/usecase/add_films_to_fav_uc.dart';
import 'package:course_work/viewModel/usecase/get_image_uc.dart';
import 'package:course_work/viewModel/usecase/has_element_in_storage_uc.dart';
import 'package:course_work/viewModel/usecase/load_favorite_films_uc.dart';
import 'package:course_work/viewModel/usecase/load_top_films_uc.dart';
import 'package:course_work/viewModel/usecase/remove_films_from_fav_uc.dart';
import 'package:course_work/viewModel/usecase/search_films_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Routes {
  static final String popular = '/popular';
  static final String favorite = '/favorite';
  static final String findPage = '/find';
  static final String aboutFilm = '/aboutFilm';
}

class MyApp extends StatelessWidget {
  final HttpRepo _httpRepo;
  final DbRepo _dbRepo;

  const MyApp(this._httpRepo, this._dbRepo, {super.key});
  @override
  Widget build(BuildContext context) {
    DbService _dbService = DbService(_dbRepo);
    HttpService _httpService = HttpService(_httpRepo);

    FilmsRepo _filmsRepo = FilmsRepo(_dbService, _httpService);

    FilmService _filmService = FilmService(_filmsRepo);

    AboutFilmsUc _aboutFilmsUc = AboutFilmsUc(_filmService);
    AddFilmsToFavUc _addFilmsToFavUc = AddFilmsToFavUc(_filmService);
    HasElementInStorageUc _hasElementInStorageUc = HasElementInStorageUc(
      _filmService,
    );
    LoadFavoriteFilmsUc _loadFavoriteFilmsUc = LoadFavoriteFilmsUc(
      _filmService,
    );
    LoadTopFilmsUc _loadTopFilmsUc = LoadTopFilmsUc(_filmService);
    RemoveFilmsFromFavUc _removeFilmsFromFavUc = RemoveFilmsFromFavUc(
      _filmService,
    );
    SearchFilmsUc _searchFilmsUc = SearchFilmsUc(_filmService);
    GetImageUc _getImageUc = GetImageUc(_filmService);

    PopularCubit popularCubit = PopularCubit(
      _addFilmsToFavUc,
      _removeFilmsFromFavUc,
      _hasElementInStorageUc,
      _loadTopFilmsUc,
      _getImageUc,
    );
    popularCubit.init(); // Где
    FavoriteCubit favoriteCubit = FavoriteCubit(
      _addFilmsToFavUc,
      _removeFilmsFromFavUc,
      _hasElementInStorageUc,
      _loadFavoriteFilmsUc,
      _getImageUc,
    );
    favoriteCubit.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (BuildContext build) => SearchCubit(
            _addFilmsToFavUc,
            _removeFilmsFromFavUc,
            _hasElementInStorageUc,
            _searchFilmsUc,
            _getImageUc,
          ),
        ),

        BlocProvider<PopularCubit>(
          create: (BuildContext build) => popularCubit,
        ),
        BlocProvider<FavoriteCubit>(create: (context) => favoriteCubit),
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
          Routes.aboutFilm: (context) => BlocProvider<AboutFilmCubit>(
            create: (BuildContext build) => AboutFilmCubit(
              _aboutFilmsUc,
              _getImageUc,
              film: ModalRoute.of(context)!.settings.arguments as Film,
            ),
            child: AboutScreen(),
          ),
          Routes.favorite: (context) => FavouriteScreen(),
          Routes.popular: (context) => PopularScreen(),
          Routes.findPage: (context) => SearchScreen(),
        },
      ),
    );
  }
}

Future<Directory> getDir() async {
  final dir = getApplicationDocumentsDirectory();
  return await dir;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  databaseFactory = databaseFactoryFfi;

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
  runApp(MyApp(HttpRepo(), DbRepo(db)));
}
