import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_simp/features/domain/usecases/get_musiclist_usecase.dart';
import 'package:music_player_simp/features/presentation/pages/home/bloc/home_bloc.dart';
import 'package:music_player_simp/features/presentation/pages/play/play_page.dart';
import 'package:music_player_simp/features/presentation/pages/playlist/playlist_page.dart';
import 'package:music_player_simp/features/presentation/widgets/music_item.dart';

import '../../../../core/network/network_call_handle.dart';
import '../../../../injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeBloc(getMusicListUseCase: di.get<GetMusicListUseCase>());

  @override
  void initState() {
    _bloc.add(const HomeEvent.getMusicList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayListPage(),
                ),
              );
            },
            icon: const Icon(Icons.favorite, color: Colors.pink),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == Status.ERROR) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              );
            } else if (state.status == Status.LOADING) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == Status.COMPLETED) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.musicList.length,
                itemBuilder: (context, index) {
                  return widgetMusicItem(
                    musicModel: state.musicList[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayPage(musicModel: state.musicList[index]),
                        ),
                      );
                    },
                  );
                },
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
