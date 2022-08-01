part of 'updates_bloc.dart';

class UpdatesBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingUpdatesState extends UpdatesBlocState {}

class LoadedUpdatesState extends UpdatesBlocState {

  final List<CurrentWeekUpdateModel> currentWeekData;
  LoadedUpdatesState({required this.currentWeekData});

  @override
  List<Object> get props => [currentWeekData];
}

class ErrorUpdatesState extends UpdatesBlocState {
  @override
  List<Object> get props => [];
}
