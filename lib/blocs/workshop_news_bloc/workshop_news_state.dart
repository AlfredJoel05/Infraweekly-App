part of 'workshop_news_bloc.dart';

abstract class WorkshopNewsState extends Equatable {
  const WorkshopNewsState();

  @override
  List<Object> get props => [];
}

class WorkshopNewsLoadingState extends WorkshopNewsState {}

class WorkshopNewsLoadedState extends WorkshopNewsState {
  final List<WorkshopNewsModel> workshopNewsData;
  const WorkshopNewsLoadedState({required this.workshopNewsData});

  @override
  List<Object> get props => [workshopNewsData];
}

class WorkshopNewsErrorState extends WorkshopNewsState {
  @override
  List<Object> get props => [];
}
