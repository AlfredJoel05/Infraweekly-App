part of 'get_previous_week_bloc.dart';

abstract class GetPreviousWeekState extends Equatable {
  const GetPreviousWeekState();
  
  @override
  List<Object> get props => [];
}

class PreviousWeekLoadingState extends GetPreviousWeekState {}

class PreviousWeekLoadedState extends GetPreviousWeekState {

  final List<PreviousWeekModel> previousWeekData;
  const PreviousWeekLoadedState({required this.previousWeekData});

  @override
  List<Object> get props => [previousWeekData];
}

class PreviousWeekErrorState extends GetPreviousWeekState {
  @override
  List<Object> get props => [];
}