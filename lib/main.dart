import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/services_locator.dart';
import 'core/utils/app_strings.dart';
import 'core/utils/themes/styles/themes.dart';
import 'core/utils/themes/controller/theme_state.dart';
import 'movies/presentation/controller/bloc_observer.dart';

import 'core/utils/themes/controller/theme_cubit.dart';

import 'movies/presentation/screens/main_screen.dart';

import 'movies/presentation/screens/movie_details_screen.dart';

void main() {
  ServicesLocator().init();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => servicesLocator<ThemeCubit>()..getThemePref(),
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: AppStrings.movies,
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            themeMode: ThemeCubit.object(context).theme,
            home: const MainScreen(),
            routes: {
              MovieDetailsScreen.route: (context) => const MovieDetailsScreen(),
            },
          );
        },
      ),
    );
  }
}
