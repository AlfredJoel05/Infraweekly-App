// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trid_travel/models/news_model/seminar_news_model.dart';
import 'package:trid_travel/repository/api_repository.dart';

part 'seminar_news_event.dart';
part 'seminar_news_state.dart';

class SeminarNewsBloc extends Bloc<SeminarNewsEvent, SeminarNewsState> {
  final ApiRepository apiRepository;
  SeminarNewsBloc({required this.apiRepository})
      : super(SeminarNewsLoadingState()) {
    on<SeminarNewsEvent>(_onLoadSeminarNews);
    on<SeminarNewsRefreshEvent>(_onRefreshSeminarNews);
  }

  void _onLoadSeminarNews(
      SeminarNewsEvent event, Emitter<SeminarNewsState> emit) async {
    final List<SeminarNewsModel>? dataList =
        await apiRepository.getSeminarNewsData();
    if (dataList!.isEmpty) {
      emit(SeminarNewsErrorState());
    } else {
      emit(SeminarNewsLoadedState(seminarNewsData: dataList));
    }
  }

  void _onRefreshSeminarNews(
      SeminarNewsRefreshEvent event, Emitter<SeminarNewsState> emit) async {
    emit(SeminarNewsLoadingState());
    final List<SeminarNewsModel>? dataList =
        await apiRepository.getSeminarNewsData();
    if (dataList!.isEmpty) {
      emit(SeminarNewsErrorState());
    } else {
      emit(SeminarNewsLoadedState(seminarNewsData: dataList));
    }
  }
}
