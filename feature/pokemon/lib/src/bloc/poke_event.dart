part of 'poke_bloc.dart';

sealed class PokeEvent extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

final class LoadPokemonsEvent extends PokeEvent {}

final class NoInternetEvent extends PokeEvent {}
