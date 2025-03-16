import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_movie_app/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb_movie_app/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:tmdb_movie_app/features/movie/domain/repositories/movie_repository.dart';
import 'package:tmdb_movie_app/features/movie/domain/usecase/get_popular_movies.dart';
import 'package:tmdb_movie_app/features/movie/presentation/bloc/movie_bloc.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // External Dependencies (API Calls)
  sl.registerLazySingleton(() => http.Client());

  // Data Sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: sl()),
  );

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Case
  sl.registerLazySingleton<GetPopularMovies>(
    () => GetPopularMovies(movieRepository: sl()),
  );

  // Bloc
  sl.registerFactory<MovieBloc>(
    () => MovieBloc(getPopularMovies: sl()),
  );
}
