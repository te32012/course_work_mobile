import 'package:course_work/controller/rest_controller.dart';
import 'package:course_work/presentation/about_film.dart';
import 'package:course_work/presentation/widget/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Main extends GetView<Restcontroller> {

  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
                  itemCount: controller.isFaivorite.value
                      ? controller.storage.value.storageList.length
                      : controller.tmp.value.films.length,
                  itemBuilder: (BuildContext context, int index) {
                    var f = controller.isFaivorite.value
                        ? controller.storage.value.storageList[index].film
                        : controller.tmp.value.films[index];
                    return GestureDetector(
                      onTap: () {
                        if (controller.isFaivorite.value) {
                          controller.fetchAdditionalAboutFilm(
                            controller.storage.value.storageList[index].film
                          ).then((_) {
                            controller.update();
                          });
                        } else {
                          controller.fetchAdditionalAboutFilm(
                            controller.tmp.value.films[index]
                          ).then((_) {
                            controller.update();
                          });
                        }
                        Get.to(
                          () => SafeArea(
                            child: Scaffold(
                              appBar: AppBar(),
                              body: AboutFilm(f),
                            ),
                          ),
                        );
                      },
                      child: PosterCart(
                        controller.buttonPressed,
                        f,
                        controller.storage.value.hasElement(f.value.filmId),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.tonal(
                onPressed: () {
                  controller.isFaivorite.value = false;
                  // controller.update();
                },
                child: Text("Популярные", style: TextStyle(fontSize: 14)),
              ),
              FilledButton(
                onPressed: () {
                  controller.isFaivorite.value = true;
                  // controller.update();
                },
                child: Text("Избранные", style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
