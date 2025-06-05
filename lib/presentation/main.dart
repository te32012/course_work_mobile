import 'package:flutter/material.dart';



class MainState extends StatefulWidget {
  const MainState({super.key});
  
  @override
  State<MainState> createState() => _MainState();
}

class _MainState extends State<MainState> {

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.all(12.00),
        child: Column(
          children: [
            Row(
              children: [
                Text("Популярные"),
                Icon(Icons.search)
              ],
            ),
            ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber[colorCodes[index]],
                  child: Center(child: Text('Entry ${entries[index]}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Container(padding: EdgeInsets.symmetric(vertical: 8.0),),
            ),
            Row(
              children: [
                FilledButton.tonal(onPressed: onPressed, child: Text("Популярные")),
                FilledButton(onPressed: onPressed, child: Text("Избранные"))
              ],
            )
          ],
        ),
      )
      
    
  }
  

  void onPressed() {
  }
}