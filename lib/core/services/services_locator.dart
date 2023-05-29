import 'package:movies/movies/domain/use%20cases/get_upcoming_movies_usecase.dart';
import 'package:movies/core/utils/themes/controller/theme_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../movies/data/data source/movie_remote_data_source.dart';
import '../../movies/data/repository/movies_repository.dart';
import '../../movies/domain/repository/base_movies_repository.dart';
import '../../movies/domain/use cases/get_movie_detail_usecase.dart';
import '../../movies/domain/use cases/get_now_playing_movies_usecase.dart';
import '../../movies/domain/use cases/get_popular_movies_usecase.dart';
import '../../movies/domain/use cases/get_recommendation_usecase.dart';
import '../../movies/domain/use cases/get_top_rated_movies_usecase.dart';
import '../../movies/presentation/controller/cubit/movie_details_cubit.dart';
import '../../movies/presentation/controller/cubit/movies_cubit.dart';

GetIt servicesLocator = GetIt.instance;

class ServicesLocator {
  void init() {
    // registerSingleton
    // دي معناه اخلقلقي ال الاوبجكت ده اول ما استدعي الدالة init
    //ودي تقريبا تقريبا نفس عمل الدالة ال initState الموجدة في ال فصل StateFullWidget
    //**

    // Bloc ( registerFactory is creating new object every time)
    //***
    // TODO: THIS IS Bloc
    servicesLocator.registerFactory(() =>
        MoviesCubit(
          getNowPlayingMoviesUseCase: servicesLocator(),
          getPopularMoviesUseCase: servicesLocator(),
          getTopRatedMoviesUseCase: servicesLocator(),
          getUpcomingMoviesUseCase: servicesLocator(),
        ));
    servicesLocator.registerFactory(
          () =>
          MovieDetailsCubit(
            getMovieDetailsUSeCase: servicesLocator(),
            getRecommendationUseCase: servicesLocator(),
          ),
    );

    servicesLocator.registerFactory(() => ThemeCubit());

    // TODO: THIS IS USE CASES
    servicesLocator.registerLazySingleton(
            () => GetNowPlayingMoviesUseCase(servicesLocator()));
    servicesLocator.registerLazySingleton(
            () => GetPopularMoviesUseCase(servicesLocator()));

    servicesLocator.registerLazySingleton(
            () => GetTopRatedMoviesUseCase(servicesLocator()));

    servicesLocator
        .registerLazySingleton(() => GetMovieDetailsUSeCase(servicesLocator()));

    servicesLocator.registerLazySingleton(
            () =>
            RecommendationUseCase(baseMoviesRepository: servicesLocator()));

    servicesLocator.registerLazySingleton(() =>
        GetUpcomingMoviesUseCase(baseMoviesRepository: servicesLocator()));

    //   TODO: THIS IS REPOSITORY
    servicesLocator.registerLazySingleton<BaseMoviesRepository>(
            () => MoviesRepository(servicesLocator()));
    //   TODO: THIS IS DATASOURCE

    servicesLocator.registerLazySingleton<BaseMovieRemoteDataSource>(
          () => MovieRemoteDataSource(),
    );
  }
//registerLazySingleton
// هي عبارة عن تثبيت مكان التخزين لل object في ال memory وللتاكد من صح هذا الكلام
// اعمل print للObject.hashCode قبل اضافتة في services locator
// ومن ثم كرر نفس الخطوة بتاعة ال print
// بعد اضافتة الناتج = توحيد كود التجزئة
}
