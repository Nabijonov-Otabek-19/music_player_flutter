import 'package:flutter/material.dart';
import 'package:music_player_simp/features/data/model/music_model.dart';

Widget widgetMusicItem({
  required MusicModel musicModel,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFffdcdc),
      ),
      child: Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: FadeInImage.assetNetwork(
                height: 60,
                width: 60,
                placeholder: "assets/images/musicplaceholder.png",
                image: musicModel.image.toString(),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  musicModel.title.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  musicModel.artist.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
