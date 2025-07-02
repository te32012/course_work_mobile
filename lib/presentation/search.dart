import 'package:course_work/controller/rest_controller.dart';
import 'package:course_work/presentation/about_film.dart';
import 'package:course_work/presentation/widget/cart.dart';
import 'package:flutter/material.dart';
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
                  print("search");
                  controller.fetchPageByKeyword(
                    text.value.text,
                  ); // Загружаем новые данные
                  text.refresh();
                  return true; //
                },
                child: ListView.builder(
                  itemCount: controller.search.value.films.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        controller.fetchAdditionalAboutFilm(
                          controller.search.value.films[index],
                        ).then((_) {
                          controller.update();
                        });
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
                        controller.storage.value.hasElement(
                          controller.search.value.films[index].value.filmId,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
