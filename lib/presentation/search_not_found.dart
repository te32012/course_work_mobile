import 'package:flutter/material.dart';

class SearchNotFound extends StatelessWidget {
  
  const SearchNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(onPressed: onPressed, child: Text("Не найдено")),
    );
  }  
}

void onPressed() {

}