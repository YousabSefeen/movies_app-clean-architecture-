import 'package:dio/dio.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/utils/api_constants.dart';
import '../../domain/use cases/get_movie_detail_usecase.dart';
import '../../domain/use cases/get_recommendation_usecase.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';
import '../models/recommendation_model.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<List<MovieModel>> getUpcomingMovies();

  Future<MovieDetailsModels> getMovieDetails(MovieDetailsParameters parameters);

  Future<List<RecommendationModel>> getRecommendations(
      RecommendationParameters parameters);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await Dio().get(ApiConstants.nowPlayingMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (movie) => MovieModel.fromJson(movie),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await Dio().get(ApiConstants.popularMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (movie) => MovieModel.fromJson(movie),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    Response response = await Dio().get(ApiConstants.topRatedMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (movie) => MovieModel.fromJson(movie),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MovieDetailsModels> getMovieDetails(
    MovieDetailsParameters parameters,
  ) async {
    final result =
        await Dio().get(ApiConstants.movieDetailsPath(parameters.movieId));

    if (result.statusCode == 200) {
      return MovieDetailsModels.fromJson(result.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(result.data),
      );
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendations(
      RecommendationParameters parameters) async {
    final result =
        await Dio().get(ApiConstants.recommendationPath(parameters.movieId));

    if (result.statusCode == 200) {
      return List<RecommendationModel>.from(
        (result.data['results'] as List).map(
          (e) => RecommendationModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(result.data));
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    final result = await Dio().get(ApiConstants.upComingMoviesPath);

    if (result.statusCode == 200) {
      return List<MovieModel>.from(
          (result.data['results'] as List).map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(result.data));
    }
  }
}
