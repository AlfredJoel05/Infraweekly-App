// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trid_travel/models/research_model/research_model.dart';
import 'package:trid_travel/repository/api_repository.dart';

part 'research_event.dart';
part 'research_state.dart';

class ResearchBloc extends Bloc<ResearchEvent, ResearchState> {
  final ApiRepository apiRepository;
  ResearchBloc({required this.apiRepository})
      : super(ResearchLoadingState()) {
    on<ResearchEvent>(_onLoadResearch);
    on<ResearchRefreshEvent>(_onRefreshResearch);
  }

  void _onLoadResearch(
      ResearchEvent event, Emitter<ResearchState> emit) async {
    final List<ResearchModel>? dataList =
        await apiRepository.getResearchData();
    if (dataList!.isEmpty) {
      emit(ResearchErrorState());
    } else {
      emit(ResearchLoadedState(researchData: dataList));
    }
  }

  void _onRefreshResearch(
      ResearchRefreshEvent event, Emitter<ResearchState> emit) async {
    emit(ResearchLoadingState());
    final List<ResearchModel>? dataList =
        await apiRepository.getResearchData();
    if (dataList!.isEmpty) {
      emit(ResearchErrorState());
    } else {
      emit(ResearchLoadedState(researchData: dataList));
    }
  }
}

