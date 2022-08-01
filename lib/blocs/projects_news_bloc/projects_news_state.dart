part of 'projects_news.dart';

abstract class ProjectsNewsState extends Equatable {
  const ProjectsNewsState();

  @override
  List<Object> get props => [];
}

class ProjectsNewsLoadingState extends ProjectsNewsState {}

class ProjectsNewsLoadedState extends ProjectsNewsState {
  final List<ProjectsNewsModel> projectsNewsData;
  const ProjectsNewsLoadedState({required this.projectsNewsData});

  @override
  List<Object> get props => [projectsNewsData];
}

class ProjectsNewsErrorState extends ProjectsNewsState {
  @override
  List<Object> get props => [];
}
