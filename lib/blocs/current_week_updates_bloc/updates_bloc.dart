// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trid_travel/models/updates_model/current_week_model.dart';
import 'package:trid_travel/repository/api_repository.dart';

part 'updates_bloc_event.dart';
part 'updates_bloc_state.dart';

class GetUpdatesBloc extends Bloc<GetUpdatesBlocEvent, UpdatesBlocState> {
  final ApiRepository apiRepository;
  GetUpdatesBloc({required this.apiRepository}) : super(LoadingUpdatesState()) {
    on<GetUpdatesBlocEvent>(_onLoadUpdates);
    on<GetUpdatesBlocRefreshEvent>(_onRefreshLoadUpdates);
  }

  void _onLoadUpdates(
      GetUpdatesBlocEvent event, Emitter<UpdatesBlocState> emit) async {
    final List<CurrentWeekUpdateModel>? dataList =
        await apiRepository.getCurrentWeekData();
    if (dataList!.isEmpty) {
      emit(ErrorUpdatesState());
    } else {
      emit(LoadedUpdatesState(currentWeekData: dataList));
    }
  }

  void _onRefreshLoadUpdates(GetUpdatesBlocRefreshEvent event, Emitter<UpdatesBlocState> emit) async {
    emit(LoadingUpdatesState());
    final List<CurrentWeekUpdateModel>? dataList = await apiRepository.getCurrentWeekData();
    if (dataList!.isEmpty) {
      emit(ErrorUpdatesState());
    } else {
      emit(LoadedUpdatesState(currentWeekData: dataList));
    }
  }
}
