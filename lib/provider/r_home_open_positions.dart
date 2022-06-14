import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:recruitment/model/httpException.dart';

class RHomeOP {
  final int id;
  final String companyName;
  final String location;
  final String designation;
  final String experience;
  final int vacancies;
  final String salary;

  RHomeOP({
    @required this.id,
    @required this.companyName,
    @required this.designation,
    @required this.location,
    @required this.experience,
    @required this.vacancies,
    @required this.salary,
  });
}

class RHomeOPP with ChangeNotifier {
  String token;
  String urlfront;
  RHomeOPP({this.token, this.urlfront});
  List<RHomeOP> _items = [];
  List<RHomeOP> get items {
    return [..._items];
  }

  Future<void> fetchJobs() async {
    final url = 'http://$urlfront/api/auth/recruiter/ViewPos/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "bearer $token",
        },
      );
      final res = json.decode(response.body);
      print('res Job positions');
      print(url);
      print(token);
      print(res);
      final List<RHomeOP> _itemList = [];
      res['data'].forEach((f) {
        _itemList.add(
          RHomeOP(
              id: f['id'],
              companyName: f['Client_Name'],
              location: f['Location'],
              experience: f['Experience'],
              designation: f['Position'],
              vacancies: f['vacancies'],
              salary: f['salary']),
        );
      });
      print(_itemList);
      _items = _itemList;
      print(res);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  // List<RHomeOP> _items = [
  //   RHomeOP(
  //       id: 1,
  //       companyName: 'Google LLC',
  //       location: 'Oklahoma, US',
  //       experience: '3-6 years',
  //       designation: 'Sales Manager',
  //       vacancies: 160),
  //   RHomeOP(
  //       id: 2,
  //       companyName: 'Mount Design Consultants',
  //       location: 'New York, US',
  //       experience: '5-6 years',
  //       designation: 'Software Developer',
  //       vacancies: 300),
  //   RHomeOP(
  //       id: 3,
  //       companyName: 'Google LLC',
  //       location: 'California, US',
  //       experience: '8-10 years',
  //       designation: 'Cloud Developer',
  //       vacancies: 10),
  //   RHomeOP(
  //       id: 4,
  //       companyName: 'Amazon',
  //       location: 'Las Vegas, US',
  //       experience: '0-2 years',
  //       designation: 'Data Analyst',
  //       vacancies: 60),
  //   RHomeOP(
  //       id: 1,
  //       companyName: 'Apple',
  //       location: 'Chicago, US',
  //       experience: '5-7 years',
  //       designation: 'Data Security',
  //       vacancies: 600),
  // ];
  Future<void> addJob(
      String client_name,
      String position,
      String experience,
      String location,
      String job_description,
      String skills,
      int vacancies,
      String salary) async {
    final url = 'http://$urlfront/api/auth/recruiter/AddNewPos/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "bearer $token"
        },
        body: json.encode(
          {
            'client_name': client_name,
            'position': position,
            'experience': experience,
            'location': location,
            'job_description': job_description,
            'skills': skills,
            'vacancies': vacancies,
            'salary': salary
          },
        ),
      );
      final res = json.decode(response.body);
      // notifyListeners();
      print("res=");
      print(res);
      _items.add(
        RHomeOP(
            id: 1,
            companyName: res['data']['Client_Name'],
            location: res['data']['Location'],
            experience: res['data']['Experience'],
            designation: res['data']['Position'],
            vacancies: res['data']['vacancies'],
            salary: res['data']['salary']),
      );
      notifyListeners();
      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }
}
