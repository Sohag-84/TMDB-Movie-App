import 'package:dartz/dartz.dart';
import 'package:tmdb_movie_app/core/error/failure.dart';
import 'package:tmdb_movie_app/features/movie/domain/entities/movie_entity.dart';

abstract interface class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies();
}
