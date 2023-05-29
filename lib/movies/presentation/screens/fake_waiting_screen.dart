import 'package:flutter/material.dart';
import 'package:movies/movies/presentation/screens/list_of_selected_movies_screen.dart';

import '../../domain/entities/movie.dart';

class FakeWaitingScreen extends StatefulWidget {
  final String title;
  final List<Movie> movies;

  const FakeWaitingScreen({
    Key? key,
    required this.title,
    required this.movies,
  }) : super(key: key);

  @override
  State<FakeWaitingScreen> createState() => _FakeWaitingScreenState();
}

class _FakeWaitingScreenState extends State<FakeWaitingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListOfSelectedMoviesScreen(
            title: widget.title,
            movies: widget.movies,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
