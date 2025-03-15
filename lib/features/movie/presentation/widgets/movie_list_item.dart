import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/features/movie/domain/entities/movie_entity.dart';

class MovieListItem extends StatelessWidget {
  final MovieEntity movie;

  const MovieListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: ListTile(
        leading: Image.network(
          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
          fit: BoxFit.cover,
          width: 50,
        ),
        title: Text(movie.title ?? ""),
        subtitle: Text(
          movie.overview ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
