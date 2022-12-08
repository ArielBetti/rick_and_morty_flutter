part of 'rick_and_morty_bloc.dart';

@immutable
abstract class RickAndMortyState {}

class RickAndMortyInitial extends RickAndMortyState {}

class RickAndMortyLoading extends RickAndMortyState {}

class RickAndMortyLoaded extends RickAndMortyState {
  final List<Results> data;

  RickAndMortyLoaded(this.data);
}

class RickAndMortyError extends RickAndMortyState {
  final String? message;

  RickAndMortyError(this.message);
}
