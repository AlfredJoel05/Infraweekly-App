// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:trid_travel/models/news_model/projects_news_model.dart';
import 'package:trid_travel/models/news_model/seminar_news_model.dart';
import 'package:trid_travel/models/news_model/workshop_news_model.dart';
import 'package:trid_travel/models/opportunitites_model/opportunities_model.dart';
import 'package:trid_travel/models/research_model/research_model.dart';
import 'package:trid_travel/models/updates_model/current_week_model.dart';
import 'package:trid_travel/models/updates_model/previous_week_model.dart';
import 'package:trid_travel/models/side_menu_model/user_details_model.dart';
import 'package:trid_travel/services/api_service.dart';

class ApiRepository {
  final ApiService apiService;

  ApiRepository({required this.apiService});

  //* User Details in Side Menu
  Future<UserDetailsModel> fetchUserDetails() async {
    final response = await apiService.getUserDetails();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = jsonEncode(data["body"]);
      return userDetailsModelFromJson(data);
    } else {
      return UserDetailsModel(
          firstName: 'Anonymous',
          lastName: 'User',
          emailId: 'unknown@user.com',
          mobile: '1234567890');
    }
  }

  //* Get This Week Updates
  Future<List<CurrentWeekUpdateModel>?> getCurrentWeekData() async {
    final response = await apiService.getCurrentWeekUpdates();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = jsonEncode(data["body"]);
      return currentWeekUpdateModelFromJson(data);
    } else {
      print('Previous Api Rpository: Error in Request');
      return [];
    }
    // return data.map((singleData) => CurrentWeekUpdateModel.fromJson(data));
  }

  //* Get Previous Week Updates
  Future<List<PreviousWeekModel>?> getPreviousWeekData() async {
    final response = await apiService.getPreviousWeekUpdates();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = jsonEncode(data["body"]);
      return previousWeekModelFromJson(data);
    } else {
      print('Previous Api Rpository: Error in Request');
      return [];
    }
    // return data.map((singleData) => CurrentWeekUpdateModel.fromJson(data));
  }

  //* Get Seminar News
  Future<List<SeminarNewsModel>?> getSeminarNewsData() async {
    final response = await apiService.getSeminarNews();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = jsonEncode(data["body"]);
      return seminarNewsModelFromJson(data);
    } else {
      print('Previous Api Rpository: Error in Request');
      return [];
    }
  }

  //* Get Workshop News
  Future<List<WorkshopNewsModel>?> getWorkshopNewsData() async {
    final response = await apiService.getWorkshopNews();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = jsonEncode(data["body"]);
      return workshopNewsModelFromJson(data);
    } else {
      print('Previous Api Rpository: Error in Request');
      return [];
    }
  }

  //* Get Projects News
  Future<List<ProjectsNewsModel>?> getProjectsNewsData() async {
    final response = await apiService.getProjectsNews();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = jsonEncode(data["body"]);
      return projectsNewsModelFromJson(data);
    } else {
      print('Previous Api Rpository: Error in Request');
      return [];
    }
  }

  //* Get Research News
  Future<List<ResearchModel>?> getResearchData() async {
    final response = await apiService.getResearch();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = jsonEncode(data["body"]);
      return researchModelFromJson(data);
    } else {
      print('Previous Api Rpository: Error in Request');
      return [];
    }
  }

  //* Get Opportunity News
  Future<List<OpportunitiesModel>?> getOpportunitiesData() async {
    final response = await apiService.getOpportunity();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = jsonEncode(data["body"]);
      return opprotunitiesModelFromJson(data);
    } else {
      print('Previous Api Rpository: Error in Request');
      return [];
    }
  }
}
