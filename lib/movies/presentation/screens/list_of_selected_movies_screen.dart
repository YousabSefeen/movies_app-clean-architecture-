import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/api_constants.dart';

import '../../../core/utils/app_constants.dart';
import '../../domain/entities/movie.dart';
import 'movie_details_screen.dart';

class ListOfSelectedMoviesScreen extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const ListOfSelectedMoviesScreen({
    Key? key,
    required this.title,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textContext = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              MovieDetailsScreen.route,
              arguments: movie.id,
            ),
            child: SizedBox(
              height: height * 0.25,
              width: double.infinity,
              child: Card(
                child: Row(
                  children: [
                    CachedNetworkImage(
                      width: width * 0.35,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: ApiConstants.imageUrl(
                        movie.backdropPath,
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[850]!,
                        highlightColor: Colors.grey[800]!,
                        child: Container(
                          width: width * 0.38,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: constraints.maxHeight * 0.4,
                                child: Text(
                                  movie.title,
                                  style: textContext.titleSmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                height: constraints.maxHeight * 0.2,
                                margin: const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Chip(
                                      label:
                                          Text(movie.releaseDate.split('-')[0]),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 2),
                                          child: Icon(Icons.star,
                                              color: Colors.amber),
                                        ),
                                        Text(
                                          movie.voteAverage.toString(),
                                          style: textContext.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: constraints.maxHeight * 0.4,
                                ),
                                child: Text(
                                  movie.overview,
                                  style: textContext.bodyLarge,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
