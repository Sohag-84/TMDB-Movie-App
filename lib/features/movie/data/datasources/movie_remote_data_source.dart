import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_movie_app/features/movie/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract interface class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  const MovieRemoteDataSourceImpl({required this.client});
  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await client.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=${dotenv.env['API_KEY']}',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> movies = jsonDecode(response.body)['results'];
        return movies.map((e) => MovieModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
