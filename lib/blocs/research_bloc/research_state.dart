part of 'research_bloc.dart';


abstract class ResearchState extends Equatable {
  const ResearchState();

  @override
  List<Object> get props => [];
}

class ResearchLoadingState extends ResearchState {}

class ResearchLoadedState extends ResearchState {
  final List<ResearchModel> researchData;
  const ResearchLoadedState({required this.researchData});

  @override
  List<Object> get props => [researchData];
}

class ResearchErrorState extends ResearchState {
  @override
  List<Object> get props => [];
}

