import 'package:dartz/dartz.dart';
import 'package:tmdb_movie_app/core/error/failure.dart';
import 'package:tmdb_movie_app/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb_movie_app/features/movie/domain/entities/movie_entity.dart';
import 'package:tmdb_movie_app/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  const MovieRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies() async {
    try {
      final movieModel = await remoteDataSource.getPopularMovies();
      final movies = movieModel
          .map((model) => MovieEntity(
                adult: model.adult,
                backdropPath: model.backdropPath,
                genreIds: model.genreIds,
                id: model.id,
                originalLanguage: model.originalLanguage,
                originalTitle: model.originalTitle,
                overview: model.overview,
                popularity: model.popularity,
                posterPath: model.posterPath,
                releaseDate: model.releaseDate,
                title: model.title,
                video: model.video,
                voteAverage: model.voteAverage,
                voteCount: model.voteCount,
              ))
          .toList();

      return Right(movies);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
