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
  const MovieLoadingSuccess({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class MovieLoadingError extends MovieState {
  final String message;
  const MovieLoadingError({required this.message});

  @override
  List<Object> get props => [message];
}
