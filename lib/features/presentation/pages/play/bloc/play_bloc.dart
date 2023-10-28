import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'play_event.dart';

part 'play_state.dart';

part 'play_bloc.freezed.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(const PlayState.initial()) {
    on<PlayEvent>((event, emit) async {
      switch (event) {
        //
      }
    });
  }
}
