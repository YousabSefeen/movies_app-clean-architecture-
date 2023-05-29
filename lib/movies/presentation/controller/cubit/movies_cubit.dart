import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/errors/failure.dart';
import 'package:movies/movies/domain/entities/movie.dart';

import '../../../../core/use cases/base_use_case.dart';
import '../../../../core/utils/enums.dart';

import '../../../domain/use cases/get_now_playing_movies_usecase.dart';
import '../../../domain/use cases/get_popular_movies_usecase.dart';
import '../../../domain/use cases/get_top_rated_movies_usecase.dart';

import '../../../domain/use cases/get_upcoming_movies_usecase.dart';
import '../states/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;

  MoviesCubit({
    required this.getNowPlayingMoviesUseCase,
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getUpcomingMoviesUseCase,
  }) : super(const MoviesState());

  FutureOr<void> getNowPlayingMovies() async {
    final result = await getNowPlayingMoviesUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          nowPlayingState: RequestState.error,
          nowPlayingMessageError: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          nowPlayingMovies: r,
          nowPlayingState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> getPopularMovies() async {
    final result = await getPopularMoviesUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          popularState: RequestState.error,
          popularMessageError: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          popularMovies: r,
          popularState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> getTopRatedMovies() async {
    final result = await getTopRatedMoviesUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
              topRatedState: RequestState.error,
              topRatedMessageError: l.message,
            )),
        (r) => emit(state.copyWith(
              topRatedMovies: r,
              topRatedState: RequestState.loaded,
            )));
  }

  FutureOr<void> getUpcomingMovies() async {
    final Either<Failure, List<Movie>> result =
        await getUpcomingMoviesUseCase(const NoParameters());

    result.fold(
        (l) => state.copyWith(
              upcomingState: RequestState.error,
              upcomingMessageError: l.message,
            ),
        (r) => emit(state.copyWith(
              upcomingMovies: r,
              upcomingState: RequestState.loaded,
            )));
  }
}
