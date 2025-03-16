import 'package:dartz/dartz.dart';
import 'package:tmdb_movie_app/core/error/failure.dart';
import 'package:tmdb_movie_app/features/movie/domain/entities/movie_entity.dart';
import 'package:tmdb_movie_app/features/movie/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository movieRepository;
  GetPopularMovies({required this.movieRepository});

  Future<Either<Failure, List<MovieEntity>>> call({required int page}) async {
    return await movieRepository.getPopularMovies(page: page);
  }
}
