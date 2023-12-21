import 'package:flutter/material.dart';

import '../util/color.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [RandomColors().getRandomColor(),RandomColors().getRandomColor()],begin: Alignment.topLeft,end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(30)
      ),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.music_note_rounded,size: 35,),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Aster Aweke"),
                Text("Aster Aweke"),
              ],
            ),
          ),
          Icon(Icons.play_circle_outline_rounded,size: 35,),
          SizedBox(width: 20,),
          Icon(Icons.skip_next_rounded,size: 35,),
          SizedBox(width: 10,),
        ],
      ),
    );
  }
}
