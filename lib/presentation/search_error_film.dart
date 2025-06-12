import 'package:flutter/material.dart';

class SearchErrorFound extends StatelessWidget {
  const SearchErrorFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Spacer(),
          Icon(Icons.cloud_off, size: 70),
          Text(
            "Произошла ошибка при загрузке данных проверьте подключение к сети",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              textBaseline: TextBaseline.alphabetic,
            ),
            softWrap: true,
            overflow: TextOverflow.clip,
            maxLines: 2,
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: FilledButton(
              onPressed: onPressed,
              child: Text("Не найдено"),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

void onPressed() {}
