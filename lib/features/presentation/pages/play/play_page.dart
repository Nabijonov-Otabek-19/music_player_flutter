import 'package:flutter/material.dart';
import 'package:music_player_simp/features/data/model/music_model.dart';

class PlayPage extends StatefulWidget {
  final MusicModel musicModel;

  const PlayPage({super.key, required this.musicModel});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.musicModel.title!),
      ),
      body: Container(),
    );
  }
}
