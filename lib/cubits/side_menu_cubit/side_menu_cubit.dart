// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trid_travel/models/side_menu_model/user_details_model.dart';
import 'package:trid_travel/repository/api_repository.dart';

part 'side_menu_state.dart';

class SideMenuCubit extends Cubit<SideMenuState> {
  final ApiRepository apiRepository;
  SideMenuCubit({required this.apiRepository}) : super(SideMenuLoadingState());

  Future<void> getUserDetails() async {
    final UserDetailsModel response = await apiRepository.fetchUserDetails();
    emit(SideMenuLoadedState(response));
  }
}
