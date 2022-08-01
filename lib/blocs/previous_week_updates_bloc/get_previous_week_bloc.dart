// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trid_travel/models/updates_model/previous_week_model.dart';
import 'package:trid_travel/repository/api_repository.dart';

part 'get_previous_week_event.dart';
part 'get_previous_week_state.dart';

class GetPreviousWeekBloc
    extends Bloc<GetPreviousWeekEvent, GetPreviousWeekState> {
  final ApiRepository apiRepository;
  GetPreviousWeekBloc({required this.apiRepository})
      : super(PreviousWeekLoadingState()) {
    on<GetPreviousWeekEvent>(_onLoadUpdates);
    on<GetPreviousBlocRefreshEvent>(_onRefreshLoadUpdates);
  }
   void _onLoadUpdates(GetPreviousWeekEvent event, Emitter<GetPreviousWeekState> emit) async {
    final List<PreviousWeekModel>? dataList = await apiRepository.getPreviousWeekData();
    print(dataList);
    if (dataList!.isEmpty) {
      emit(PreviousWeekErrorState());
    } else {
      emit(PreviousWeekLoadedState(previousWeekData: dataList));
    }
  }

  void _onRefreshLoadUpdates(GetPreviousBlocRefreshEvent event, Emitter<GetPreviousWeekState> emit) async {
    emit(PreviousWeekLoadingState());
    final List<PreviousWeekModel>? dataList = await apiRepository.getPreviousWeekData();
    print(dataList);
    if (dataList!.isEmpty) {
      emit(PreviousWeekErrorState());
    } else {
      emit(PreviousWeekLoadedState(previousWeekData: dataList));
    }
  }

}


