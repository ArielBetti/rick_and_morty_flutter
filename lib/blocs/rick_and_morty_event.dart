part of 'rick_and_morty_bloc.dart';

@immutable
abstract class RickAndMortyEvent extends Equatable {
  rickAndMortyEvent();

  @override
  List<Object> get props => [];
}

class GetRickAndMortyCharacterList extends RickAndMortyEvent {
  @override
  rickAndMortyEvent() {
    // TODO: implement rickAndMortyEvent
    throw UnimplementedError();
  }
}
