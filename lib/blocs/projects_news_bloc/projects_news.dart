// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trid_travel/models/news_model/projects_news_model.dart';
import 'package:trid_travel/repository/api_repository.dart';

part 'projects_news_event.dart';
part 'projects_news_state.dart';

class ProjectsNewsBloc extends Bloc<ProjectsNewsEvent, ProjectsNewsState> {
  final ApiRepository apiRepository;
  ProjectsNewsBloc({required this.apiRepository})
      : super(ProjectsNewsLoadingState()) {
    on<ProjectsNewsEvent>(_onLoadProjectsNews);
    on<ProjectsNewsRefreshEvent>(_onRefreshProjectsNews);
  }

  void _onLoadProjectsNews(
      ProjectsNewsEvent event, Emitter<ProjectsNewsState> emit) async {
    final List<ProjectsNewsModel>? dataList =
        await apiRepository.getProjectsNewsData();
    if (dataList!.isEmpty) {
      emit(ProjectsNewsErrorState());
    } else {
      emit(ProjectsNewsLoadedState(projectsNewsData: dataList));
    }
  }

  void _onRefreshProjectsNews(
      ProjectsNewsRefreshEvent event, Emitter<ProjectsNewsState> emit) async {
    emit(ProjectsNewsLoadingState());
    final List<ProjectsNewsModel>? dataList =
        await apiRepository.getProjectsNewsData();
    if (dataList!.isEmpty) {
      emit(ProjectsNewsErrorState());
    } else {
      emit(ProjectsNewsLoadedState(projectsNewsData: dataList));
    }
  }
}
