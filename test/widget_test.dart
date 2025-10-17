// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:course_work/model/entity/film.dart';
import 'package:course_work/view/widget/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:course_work/main.dart';
import 'package:course_work/view/widget/cart.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Создаем тестовый фильм
    final testFilm = Film(
      filmId: 1,
      nameRu: 'Тестовый фильм',
      year: '2023',
      genres: [],
    );

    // Оборачиваем в MaterialApp для Directionality
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PosterCart(testFilm, () {}),
        ),
      ),
    );

    // Или если нужно проверить golden test:
    await expectLater(
      find.byType(PosterCart),
      matchesGoldenFile('goldens/confirm_button.png'),
    );
  });
}