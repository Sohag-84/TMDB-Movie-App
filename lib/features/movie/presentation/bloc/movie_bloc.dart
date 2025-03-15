import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movie_app/features/movie/domain/entities/movie_entity.dart';
import 'package:tmdb_movie_app/features/movie/domain/usecase/get_popular_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies getPopularMovies;

  MovieBloc({required this.getPopularMovies}) : super(MovieInitial()) {
    on<GetMovieList>((event, emit) async {
      emit(MovieLoading());
      final result = await getPopularMovies();

      result.fold(
        (failure) => emit(
          MovieLoadingError(message: failure.message),
        ),
        (success) => emit(
          MovieLoadingSuccess(movies: success),
        ),
      );
    });
  }
}
