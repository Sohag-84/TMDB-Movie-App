import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movie_app/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:tmdb_movie_app/features/movie/presentation/widgets/movie_list_item.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(GetMovieList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie"),
        centerTitle: true,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoadingSuccess) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = state.movies[index];
                return MovieListItem(movie: movie);
              },
            );
          } else if (state is MovieLoadingError) {
            return const Center(child: Text("Error"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
