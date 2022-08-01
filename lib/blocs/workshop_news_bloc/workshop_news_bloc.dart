// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trid_travel/models/news_model/workshop_news_model.dart';
import 'package:trid_travel/repository/api_repository.dart';

part 'workshop_news_event.dart';
part 'workshop_news_state.dart';

class WorkshopNewsBloc extends Bloc<WorkshopNewsEvent, WorkshopNewsState> {
  final ApiRepository apiRepository;
  WorkshopNewsBloc({required this.apiRepository})
      : super(WorkshopNewsLoadingState()) {
    on<WorkshopNewsEvent>(_onLoadWorkshopNews);
    on<WorkshopNewsRefreshEvent>(_onRefreshWorkshopNews);
  }

  void _onLoadWorkshopNews(
      WorkshopNewsEvent event, Emitter<WorkshopNewsState> emit) async {
    final List<WorkshopNewsModel>? dataList =
        await apiRepository.getWorkshopNewsData();
    if (dataList!.isEmpty) {
      emit(WorkshopNewsErrorState());
    } else {
      emit(WorkshopNewsLoadedState(workshopNewsData: dataList));
    }
  }

  void _onRefreshWorkshopNews(
      WorkshopNewsRefreshEvent event, Emitter<WorkshopNewsState> emit) async {
    emit(WorkshopNewsLoadingState());
    final List<WorkshopNewsModel>? dataList =
        await apiRepository.getWorkshopNewsData();
    if (dataList!.isEmpty) {
      emit(WorkshopNewsErrorState());
    } else {
      emit(WorkshopNewsLoadedState(workshopNewsData: dataList));
    }
  }
}
