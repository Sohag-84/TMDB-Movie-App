import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movie_app/features/movie/domain/entities/movie_entity.dart';
import 'package:tmdb_movie_app/features/movie/domain/usecase/get_popular_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies getPopularMovies;

  int currentPage = 1;
  bool hasReachedMax = false;
  bool isFetching = false;
  List<MovieEntity> movies = [];

  MovieBloc({required this.getPopularMovies}) : super(MovieInitial()) {
    on<GetMovieList>((event, emit) async {
      if (isFetching || hasReachedMax) return;

      isFetching = true;

      if (currentPage == 1) {
        emit(MovieLoading());
      }

      final result = await getPopularMovies(page: currentPage);

      result.fold((failure) {
        isFetching = false;
        emit(
          MovieLoadingError(message: failure.message),
        );
      }, (newMovies) {
        if (newMovies.isEmpty) {
          hasReachedMax = true;
        } else {
          movies.addAll(newMovies);
          currentPage++;
        }
        emit(
          MovieLoadingSuccess(
            movies: List.from(movies),
            hasReachedMax: true,
          ),
        );
        isFetching = false;
      });
    });
  }
}
