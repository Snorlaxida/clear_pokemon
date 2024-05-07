import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:domain/domain.dart' show GetPokemonPageUsecase, PokeListPart;
import 'package:domain/src/domain/entity/poke_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream_transform/stream_transform.dart';

part 'poke_event.dart';
part 'poke_state.dart';

const Duration throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (Stream<E> events, Stream<E> Function(E) mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PokeBloc extends Bloc<PokeEvent, PokeState> {
  final GetPokemonPageUsecase pokemonPageUsecase;

  PokeBloc({
    required this.pokemonPageUsecase,
  }) : super(const PokeState()) {
    on<LoadPokemonsEvent>(
      _onLoadPokemonsEvent,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onLoadPokemonsEvent(
    PokeEvent event,
    Emitter<PokeState> emit,
  ) async {
    try {
      if (state.status == PokeStatus.initial) {
        final PokePage pokePage = await pokemonPageUsecase.call();
        return emit(state.copyWith(
          status: PokeStatus.success,
          hasReachedMax: !pokePage.hasNext,
          pokeList: pokePage.pokeList,
        ));
      }
      if (state.hasReachedMax) {
        return;
      }
      final PokePage pokePage =
          await pokemonPageUsecase.call(params: state.pokeList.length);
      return pokePage.hasNext
          ? emit(state.copyWith(
              status: PokeStatus.success,
              hasReachedMax: false,
              pokeList: List<PokeListPart>.of(state.pokeList)
                ..addAll(pokePage.pokeList!),
            ))
          : emit(state.copyWith(hasReachedMax: true));
    } catch (e) {
      emit(state.copyWith(status: PokeStatus.failure));
    }
  }
}
