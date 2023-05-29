import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/utils/api_constants.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/enums.dart';

import '../../domain/entities/genres.dart';
import '../../domain/entities/recommendation.dart';
import '../controller/cubit/movie_details_cubit.dart';
import '../controller/states/movie_details_state.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textContext = Theme.of(context).textTheme;
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        switch (state.movieDetailsState) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: height * 0.4,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: ApiConstants.imageUrl(
                        state.movieDetails!.backdropPath,
                      ),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: ApiConstants.imageUrl(
                          state.movieDetails!.backdropPath,
                        ),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.02, horizontal: width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.movieDetails!.title,
                              style: textContext.titleSmall!.copyWith(
                                letterSpacing: 1.2,
                              )),
                          SizedBox(height: height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  state.movieDetails!.releaseDate.split('-')[0],
                                  style: textContext.bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber),
                                  SizedBox(width: width * 0.01),
                                  Text(
                                    (state.movieDetails!.voteAverage)
                                        .toStringAsFixed(1),
                                    style: textContext.bodyMedium,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_outlined),
                                  SizedBox(width: width * 0.01),
                                  Text(
                                    _showDuration(state.movieDetails!.runtime),
                                    style: textContext.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.04),
                          Text(
                            state.movieDetails!.overview,
                            style: textContext.bodyLarge!.copyWith(
                              fontSize: width * 0.05,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          RichText(
                            text: TextSpan(
                              text: AppStrings.genres,
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: Colors.amber,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: _showGenres(state.movieDetails!.genres),
                                  style: textContext.titleLarge,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                  sliver: SliverToBoxAdapter(
                    child: FadeInDown(
                      from: 200,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        AppStrings.moreLikeThis,
                        style: textContext.titleLarge,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                  sliver: _showRecommendations(state.recommendations),
                ),
              ],
            );
          case RequestState.error:
            return Center(
              child: Text(state.movieDetailsMessage),
            );
        }
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations(List<Recommendation> recommendations) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
        crossAxisCount: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: recommendations.length,
        (context, index) {
          final recommendation = recommendations[index];
          return FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: recommendation.backdropPath != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: CachedNetworkImage(
                      imageUrl:
                          ApiConstants.imageUrl(recommendation.backdropPath!),
                      placeholder: (context, url) => Shimmer.fromColors(
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
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red.shade900,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        AppStrings.noImage,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
