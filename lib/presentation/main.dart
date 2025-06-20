import 'package:course_work/controller/rest_controller.dart';
import 'package:course_work/presentation/about_film.dart';
import 'package:course_work/presentation/application.dart';
import 'package:course_work/presentation/widget/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Main extends GetView<Restcontroller> {
  var isFavorite = false.obs;

  Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 11,
            child: Obx(() {
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!scrollInfo.metrics.atEdge) {
                    return false; // Если не достигли края
                  }
                  if (scrollInfo.metrics.pixels == 0) {
                    return false; // Если на верхней части
                  }
                  controller.fetchPageTopFilm(); // Загружаем новые данные
                  return true; //
                },
                child: ListView.builder(
                  itemCount: isFavorite.value
                      ? controller.storage.value.storageList.length
                      : controller.tmp.value.films.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        if (!isFavorite.value) {
                          var film = await controller.fetchFilmById(
                            controller.tmp.value.films[index].filmId,
                          );
                          controller.tmp.value.films[index].description =
                              film.description != null
                              ? film.description!
                              : "нет описания";
                        }
                        Get.to(
                          () => SafeArea(
                            child: Scaffold(
                              appBar: AppBar(),
                              body: AboutFilm(
                                isFavorite.value
                                    ? controller
                                          .storage
                                          .value
                                          .storageList[index]
                                          .film
                                    : controller.tmp.value.films[index],
                              ),
                            ),
                          ),
                        );
                      },
                      child: PosterCart(
                        controller.buttonPressed,
                        isFavorite.value
                            ? controller.storage.value.storageList[index].film
                            : controller.tmp.value.films[index],
                        false.obs,
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    isFavorite.value = false;
                  },
                  child: Text("Популярные", style: TextStyle(fontSize: 14)),
                ),
                FilledButton(
                  onPressed: () => {isFavorite.value = true},
                  child: Text("Избранные", style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
