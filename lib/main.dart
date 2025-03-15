import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_movie_app/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb_movie_app/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:tmdb_movie_app/features/movie/domain/usecase/get_popular_movies.dart';
import 'package:tmdb_movie_app/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:tmdb_movie_app/features/movie/presentation/pages/movie_page.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GetPopularMovies>(
          create: (context) => GetPopularMovies(
            movieRepository: MovieRepositoryImpl(
              remoteDataSource: MovieRemoteDataSourceImpl(
                client: http.Client(),
              ),
            ),
          ),
        ),
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(
            getPopularMovies: context.read<GetPopularMovies>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TMDB',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MoviePage(),
      ),
    );
  }
}
