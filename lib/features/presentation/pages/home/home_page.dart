import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_simp/features/domain/usecases/get_musiclist_usecase.dart';
import 'package:music_player_simp/features/presentation/pages/home/bloc/home_bloc.dart';
import 'package:music_player_simp/features/presentation/pages/play/play_page.dart';

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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayPage(musicModel: state.musicList[index]),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, bottom: 8, right: 8, top: 4),
                            child: SizedBox(
                              child: FadeInImage.assetNetwork(
                                height: 60,
                                width: 60,
                                placeholder:
                                "assets/images/musicplaceholder.png",
                                image: state.musicList[index].image.toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.musicList[index].title.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.musicList[index].artist.toString(),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
