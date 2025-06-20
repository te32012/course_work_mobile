import 'package:course_work/controller/rest_controller.dart';
import 'package:course_work/presentation/about_film.dart';
import 'package:course_work/presentation/widget/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Search extends GetView<Restcontroller> {
  Rx<TextEditingController> text;

  Search(this.text, {super.key});

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
                  controller.fetchPageByKeyword(
                    text.value.text,
                  ); // Загружаем новые данные
                  return true; //
                },
                child: ListView.builder(
                  itemCount: controller.search.value.films.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        var film = await controller.fetchFilmById(
                          controller.tmp.value.films[index].filmId,
                        );
                        controller.tmp.value.films[index].description =
                            film.description != null
                            ? film.description!
                            : "нет описания";
                        Get.to(
                          () => SafeArea(
                            child: Scaffold(
                              appBar: AppBar(),
                              body: AboutFilm(
                                controller.search.value.films[index],
                              ),
                            ),
                          ),
                        );
                      },
                      child: PosterCart(
                        controller.buttonPressed,
                        controller.search.value.films[index],
                        false.obs,
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          Spacer(flex:1),
        ],
      ),
    );
  }
}
