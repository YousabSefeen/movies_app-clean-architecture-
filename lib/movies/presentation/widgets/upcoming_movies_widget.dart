import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/presentation/controller/cubit/movies_cubit.dart';
import 'package:movies/movies/presentation/controller/states/movies_state.dart';
import 'package:movies/movies/presentation/screens/fake_waiting_screen.dart';
import 'package:movies/movies/presentation/widgets/title_name_%20and_see_more.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/api_constants.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/enums.dart';

class UpcomingMoviesWidget extends StatelessWidget {
  const UpcomingMoviesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      buildWhen: (previous, current) =>
          previous.upcomingState != current.upcomingState,
      builder: (context, state) {
        switch (state.upcomingState) {
          case RequestState.loading:
            return const SizedBox();
          case RequestState.loaded:
            return Column(
              children: [
                TitleNameAndSeeMore(
                  title: AppStrings.upcomingMovies,
                  fontSizeText: width * 0.05,
                  seeMoreOnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => FakeWaitingScreen(
                                movies: state.upcomingMovies,
                                title: AppStrings.upcomingMovies,
                              )),
                    );
                  },
                ),
                FadeInRight(
                  from: 500,
                  child: SizedBox(
                    height: height * 0.2,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: state.upcomingMovies.length,
                      itemBuilder: (context, index) {
                        final movie = state.upcomingMovies[index];
                        return Container(
                          padding: EdgeInsets.only(right: width * 0.03),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            child: CachedNetworkImage(
                              width: width * 0.4,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              imageUrl:
                                  ApiConstants.imageUrl(movie.backdropPath),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor: Colors.grey[800]!,
                                child: Container(
                                  height: height * 0.2,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          case RequestState.error:
            return ErrorWidget(state.upcomingMessageError);
        }
      },
    );
  }
}
