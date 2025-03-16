part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieLoadingSuccess extends MovieState {
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  const MovieLoadingSuccess({
    required this.movies,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [movies, hasReachedMax];
}

final class MovieLoadingError extends MovieState {
  final String message;
  const MovieLoadingError({required this.message});

  @override
  List<Object> get props => [message];
}
