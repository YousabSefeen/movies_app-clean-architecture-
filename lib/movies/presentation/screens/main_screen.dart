import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';

import '../../../core/utils/themes/controller/theme_cubit.dart';

import '../controller/cubit/movies_cubit.dart';
import '../widgets/now_playing_widget.dart';
import '../widgets/popular_widget.dart';
import '../widgets/top_rated_widget.dart';
import '../widgets/upcoming_movies_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeCubit.object(context).theme == ThemeMode.dark;
    return BlocProvider(
      create: (_) => servicesLocator<MoviesCubit>()
        ..getNowPlayingMovies()
        ..getPopularMovies()
        ..getTopRatedMovies()
        ..getUpcomingMovies(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.movies),
          leading: IconButton(
            onPressed: () => ThemeCubit.object(context).changeTheme(),
            icon: Icon(
              isDark ? Icons.sunny : Icons.dark_mode_rounded,
              color: isDark ? Colors.amber : Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            key: const Key(AppStrings.movieScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NowPlayingWidget(),
                const TopRatedWidget(),
                const UpcomingMoviesWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.03,
                    horizontal: width * 0.04,
                  ),
                  child: Text(
                    AppStrings.popular,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const PopularWidget(),
                SizedBox(height: height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
