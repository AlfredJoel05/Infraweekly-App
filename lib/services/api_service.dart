import 'package:http/http.dart' as http;
import 'package:trid_travel/constants/constants_values.dart';

class ApiService {
  //? If skip is clicked, then you wont get JWT Token! ask them to sign in or login
  Future<http.Response> getUserDetails() async {
    if (getIsLoggedIn()) {
      final response = await http.get(
        Uri.parse('https://infraweekly.herokuapp.com/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': getJwt().toString()
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw http.Response('Connection Time Out', 408);
      });
      return response;
    } else {
      return http.Response('User Unauthorized', 401);
    }
  }

  Future<http.Response> getCurrentWeekUpdates() async {
    try {
      final response = await http.get(
        Uri.parse('https://infraweekly.herokuapp.com/currentweekupdates'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': getJwt().toString()
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw http.Response('Connection Time Out', 408);
      });
      return response;
    } catch (e) {
      return http.Response('error', 400);
    }
  }

  Future<http.Response> getPreviousWeekUpdates() async {
    var startDate = getPreviousDate();
    var endDate = getCurrentDate();
    try {
      final response = await http.get(
        Uri.parse(
            'https://infraweekly.herokuapp.com/lastweekupdates?endDate=$endDate&startDate=$startDate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': getJwt().toString()
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw http.Response('Connection Time Out', 408);
      });
      return response;
    } catch (e) {
      return http.Response('error', 400);
    }
  }

  Future<http.Response> getSeminarNews() async {
    try {
      final response = await http.get(
        Uri.parse('https://infraweekly.herokuapp.com/news/1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': getJwt().toString()
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw http.Response('Connection Time Out', 408);
      });
      return response;
    } catch (e) {
      return http.Response('error', 400);
    }
  }

  Future<http.Response> getWorkshopNews() async {
    try {
      final response = await http.get(
        Uri.parse('https://infraweekly.herokuapp.com/news/2'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': getJwt().toString()
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw http.Response('Connection Time Out', 408);
      });
      return response;
    } catch (e) {
      return http.Response('error', 400);
    }
  }

  Future<http.Response> getProjectsNews() async {
    try {
      final response = await http.get(
        Uri.parse('https://infraweekly.herokuapp.com/news/3'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': getJwt().toString()
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw http.Response('Connection Time Out', 408);
      });
      return response;
    } catch (e) {
      return http.Response('error', 400);
    }
  }

  Future<http.Response> getResearch() async {
    try {
      final response = await http.get(
        Uri.parse('https://infraweekly.herokuapp.com/news/4'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': getJwt().toString()
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw http.Response('Connection Time Out', 408);
      });
      return response;
    } catch (e) {
      return http.Response('error', 400);
    }
  }

  Future<http.Response> getOpportunity() async {
    try {
      final response = await http.get(
        Uri.parse('https://infraweekly.herokuapp.com/news/5'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': getJwt().toString()
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw http.Response('Connection Time Out', 408);
      });
      return response;
    } catch (e) {
      return http.Response('error', 400);
    }
  }

  Future<http.Response> postFeedboack(data) async {
    try {
      final response = await http
          .post(
        Uri.parse('https://infraweekly.herokuapp.com/feedback'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': getJwt().toString()
        },
        body: data,
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw http.Response('Connection Time Out', 408);
      });
      return response;
    } catch (e) {
      return http.Response('error', 400);
    }
  }
}

Future<http.Response> deleteUpdate(data) async {
  try {
    final response = await http.delete(
      Uri.parse('https://infraweekly.herokuapp.com/deleteupdate/$data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw http.Response('Connection Time Out', 408);
    });
    return response;
  } catch (e) {
    return http.Response('error', 400);
  }
}

Future<http.Response> deleteNews(data) async {
  try {
    final response = await http.delete(
      Uri.parse('https://infraweekly.herokuapp.com/deletenews/$data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw http.Response('Connection Time Out', 408);
    });
    return response;
  } catch (e) {
    return http.Response('error', 400);
  }
}
