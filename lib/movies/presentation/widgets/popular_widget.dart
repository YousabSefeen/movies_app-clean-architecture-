import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/presentation/screens/movie_details_screen.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/utils/api_constants.dart';

import '../../../core/utils/app_constants.dart';
import '../../../core/utils/enums.dart';

import '../controller/cubit/movies_cubit.dart';

import '../controller/states/movies_state.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      buildWhen: (previous, current) =>
          previous.popularState != current.popularState,
      builder: (context, state) {
        switch (state.popularState) {
          case RequestState.loading:
            return const SizedBox();

          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: width * 0.5,
                  childAspectRatio: 3 / 4,

                  /// It is very important that someone else can get me an error
                ),
                itemCount: state.popularMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.popularMovies[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: height * 0.35,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            MovieDetailsScreen.route,
                            arguments: movie.id,
                          );
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              child: CachedNetworkImage(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                imageUrl:
                                    ApiConstants.imageUrl(movie.backdropPath),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[850]!,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    height: 170.0,
                                    width: 120.0,
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
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: height * 0.13,
                              ),
                              padding: const EdgeInsets.all(7),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                              ),
                              child: Text(
                                movie.title,
                                style: TextStyle(
                                    fontSize: width * 0.06,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: 400,
              child: Center(
                child: Text(state.popularMessageError),
              ),
            );
        }
      },
    );
  }
}
