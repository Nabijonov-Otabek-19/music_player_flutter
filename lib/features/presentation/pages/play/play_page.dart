import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_simp/features/data/model/music_model.dart';

class PlayPage extends StatefulWidget {
  final MusicModel musicModel;

  const PlayPage({super.key, required this.musicModel});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    // listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.musicModel.image.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.musicModel.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                url,
                height: MediaQuery.of(context).size.height / 2.75,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              widget.musicModel.title!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              widget.musicModel.artist!,
              style: const TextStyle(fontSize: 20),
            ),
            Slider(
              value: position.inSeconds.toDouble(),
              min: 0,
              activeColor: Colors.blue,
              max: duration.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                // optional :Play audio if was paused
                await audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration - position)),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.resume();
                  }
                },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setAudio() async {
    // Repeat song when completed
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.setSourceUrl(widget.musicModel.source.toString());
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, twoDigitMinutes, twoDigitSeconds]
        .join(':');
  }
}
