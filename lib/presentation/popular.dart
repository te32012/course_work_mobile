import 'package:course_work/controller/RESTController.dart';
import 'package:course_work/presentation/about_film.dart';
import 'package:course_work/presentation/widget/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Popular extends GetView<Restcontroller> {
  const Popular({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!scrollInfo.metrics.atEdge) return false; // Если не достигли края
          if (scrollInfo.metrics.pixels == 0) {
            return false; // Если на верхней части
          }
          controller.fetchPageTopFilm(); // Загружаем новые данные
          return true; //
        },
        child: Container(
          padding: EdgeInsets.all(15.00),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Get.to(
                        SafeArea(
                          child: Scaffold(
                            appBar: AppBar(),
                            body: AboutFilm(
                              fullname: "fullname",
                              about: "aboutfilm",
                              countris: "c1, c2",
                              types: "t1, t2",
                              poster: "assets/images/two.png",
                            ),
                          ),
                        ),
                      ),
                      child: PosterCart(
                        name: controller.films[index].nameRu,
                        type: controller.films[index].genres
                            .map((e) => e.genre)
                            .reduce((e1, e2) => "$e1, $e2"),
                        year: controller.films[index].year,
                        poster: controller.films[index].posterUrl,
                        isFavorite: true,
                      ),
                    );
                  },
                ),

                /*
             ListView.separated(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return (GestureDetector
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SafeArea(
                        child: AboutFilm(
                          fullname: "fullname",
                          about: "aboutfilm",
                          countris: "c1, c2",
                          types: "t1, t2",
                          poster: "assets/images/two.png",
                        ),
                      ),
                    ),
                  ),
                  child: PosterCart(
                    name: "filmname",
                    type: "filmtype",
                    year: "2020",
                    poster: "assets/images/two.png",
                    isFavorite: true,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(thickness: 0, height: 0, color: Color.fromARGB(0, 255, 255, 255),),
            ),*/
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.tonal(
                      onPressed: onPressed,
                      child: Text("Популярные", style: TextStyle(fontSize: 14)),
                    ),
                    FilledButton(
                      onPressed: onPressed,
                      child: Text("Избранные", style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void onPressed() {}
}
