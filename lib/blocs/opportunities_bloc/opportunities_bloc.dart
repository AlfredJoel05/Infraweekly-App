// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trid_travel/models/opportunitites_model/opportunities_model.dart';
import 'package:trid_travel/repository/api_repository.dart';

part 'opportunities_event.dart';
part 'opportunities_state.dart';

class OpportunitiesBloc extends Bloc<OpportunitiesEvent, OpportunitiesState> {
  final ApiRepository apiRepository;
  OpportunitiesBloc({required this.apiRepository})
      : super(OpportunitiesLoadingState()) {
    on<OpportunitiesEvent>(_onLoadOpportunities);
    on<OpportunitiesRefreshEvent>(_onRefreshOpportunities);
  }

  void _onLoadOpportunities(
      OpportunitiesEvent event, Emitter<OpportunitiesState> emit) async {
    final List<OpportunitiesModel>? dataList =
        await apiRepository.getOpportunitiesData();
    if (dataList!.isEmpty) {
      emit(OpportunitiesErrorState());
    } else {
      emit(OpportunitiesLoadedState(opportunitiesData: dataList));
    }
  }

  void _onRefreshOpportunities(
      OpportunitiesRefreshEvent event, Emitter<OpportunitiesState> emit) async {
    emit(OpportunitiesLoadingState());
    final List<OpportunitiesModel>? dataList =
        await apiRepository.getOpportunitiesData();
    if (dataList!.isEmpty) {
      emit(OpportunitiesErrorState());
    } else {
      emit(OpportunitiesLoadedState(opportunitiesData: dataList));
    }
  }
}


