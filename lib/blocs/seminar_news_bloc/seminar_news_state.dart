part of 'seminar_news_bloc.dart';

abstract class SeminarNewsState extends Equatable {
  const SeminarNewsState();

  @override
  List<Object> get props => [];
}

class SeminarNewsLoadingState extends SeminarNewsState {}

class SeminarNewsLoadedState extends SeminarNewsState {
  final List<SeminarNewsModel> seminarNewsData;
  const SeminarNewsLoadedState({required this.seminarNewsData});

  @override
  List<Object> get props => [seminarNewsData];
}

class SeminarNewsErrorState extends SeminarNewsState {
  @override
  List<Object> get props => [];
}
