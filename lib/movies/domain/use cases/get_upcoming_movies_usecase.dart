import 'package:dartz/dartz.dart';

import 'package:movies/core/errors/failure.dart';
import 'package:movies/core/use%20cases/base_use_case.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/repository/base_movies_repository.dart';

class GetUpcomingMoviesUseCase extends BaseUseCase<List<Movie>, NoParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetUpcomingMoviesUseCase({required this.baseMoviesRepository});

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async {
    return await baseMoviesRepository.getUpcomingMovies();
  }
}
