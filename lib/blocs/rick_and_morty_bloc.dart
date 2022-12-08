import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../models/RickAndMortyCharacter.dart';
import '../services/rick_and_morty_character_service.dart';

part 'rick_and_morty_event.dart';

part 'rick_and_morty_state.dart';

class RickAndMortyBloc extends Bloc<RickAndMortyEvent, RickAndMortyState> {
  RickAndMortyBloc() : super(RickAndMortyInitial()) {
    RickAndMortyCharacterService service = RickAndMortyCharacterService();
    on<GetRickAndMortyCharacterList>((event, emit) async {
      try {
        emit(RickAndMortyLoading());
        final mList = await service.getAll();
        emit(RickAndMortyLoaded(mList));
      } on NetworkError {
        emit(RickAndMortyError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
