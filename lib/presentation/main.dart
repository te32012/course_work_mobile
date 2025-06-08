import 'package:course_work/presentation/about_film.dart';
import 'package:course_work/presentation/cart.dart';
import 'package:flutter/material.dart';

class MainDisplay extends StatefulWidget {
  const MainDisplay({super.key});
  
  @override
  State<MainDisplay> createState() => _MainState();
}

class _MainState extends State<MainDisplay> {

  @override
  Widget build(BuildContext context) {
      var uh = MediaQuery.sizeOf(context).height / 24;
      var uw = MediaQuery.sizeOf(context).width - 50;
      return Container(
        padding: EdgeInsets.all(20.00),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                    maxHeight: 2*uh,
                    maxWidth: uw
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Популярные"),
                        Icon(Icons.search)
                      ],
                  ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                    maxHeight: 16*uh,
                    maxWidth: uw
                  ),
              child: ListView.separated(
                  padding: const EdgeInsets.all(4),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context,  MaterialPageRoute(builder: (BuildContext context) => SafeArea(child: AboutFilm(fullname: "fullname", about: "aboutfilm", countris: "c1, c2", types: "t1, t2", poster: "assets/images/two.png"))) ),
                      child: PosterCart(name: "filmname", type: "filmtype", year: "2020", poster: "assets/images/two.png", isFavorite: true)
                      );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                    maxHeight: 2*uh,
                    maxWidth: uw
                  ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.tonal(onPressed: onPressed, child: Text("Популярные")),
                    FilledButton(onPressed: onPressed, child: Text("Избранные"))
                  ],
                )

            ),
          ],
        ),
      );
  }
  
  void onPressed() {
  }
}