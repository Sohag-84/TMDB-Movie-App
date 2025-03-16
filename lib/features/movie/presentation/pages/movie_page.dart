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
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(GetMovieList());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<MovieBloc>().add(GetMovieList());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Movie",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoadingSuccess) {
            if (state.movies.isEmpty) {
              return const Center(child: Text("No movies found."));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.movies.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.movies.length) {
                  return const Center(child: CircularProgressIndicator());
                }
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
