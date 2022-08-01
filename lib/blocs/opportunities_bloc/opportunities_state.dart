part of 'opportunities_bloc.dart';

abstract class OpportunitiesState extends Equatable {
  const OpportunitiesState();

  @override
  List<Object> get props => [];
}

class OpportunitiesLoadingState extends OpportunitiesState {}

class OpportunitiesLoadedState extends OpportunitiesState {
  final List<OpportunitiesModel> opportunitiesData;
  const OpportunitiesLoadedState({required this.opportunitiesData});

  @override
  List<Object> get props => [opportunitiesData];
}

class OpportunitiesErrorState extends OpportunitiesState {
  @override
  List<Object> get props => [];
}