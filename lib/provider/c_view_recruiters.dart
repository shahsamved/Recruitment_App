import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CViewRecruiters {
  final int id;
  final String designation;
  final String experience;
  final String salary;
  final String jobdetails;
  final String skills;
  final DateTime jobposting;
  CViewRecruiters({
    this.id,
    this.designation,
    this.experience,
    this.salary,
    this.jobdetails,
    this.skills,
    this.jobposting,
  });
}

class CViewRecruitersP with ChangeNotifier {
  String token;
  String urlfront;
  CViewRecruitersP({this.token, this.urlfront});
  List<CViewRecruiters> _items = [];
  List<CViewRecruiters> get items {
    return [..._items];
  }

  Future<void> fetchJobs(int id) async {
    final url = 'http://$urlfront/api/auth/recruiter/viewSpecificJobs/';
    try {
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "bearer $token",
          },
          body: json.encode(
            {
              'id': id,
            },
          ));
      final res = json.decode(response.body);
      print('fetch list of recruiters');
      print(id);
      print(res);
      final List<CViewRecruiters> _itemList = [];
      res['data'].forEach((f) {
        print("oookkk");
        //print(DateTime.parse(f['created_at'].toString()));
        //print(DateTime.parse(f['created_at'].toString()));
        // print(DateTime.fromMicrosecondsSinceEpoch(
        //     f['created_at'].microsecondsSinceEpoch));
        _itemList.add(
          CViewRecruiters(
              id: f['id'],
              designation: f['Position'],
              experience: f['Experience'],
              jobposting: DateTime.parse(f['created_at'].toString()),
              salary: f['salary'],
              jobdetails: f['job_description'],
              skills: f['skills']),
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

  //   CViewRecruiters(
  //       id: 1,
  //       designation: 'UI / UX Designer',
  //       experience: '2 - 3 Years',
  //       salary: '\$30k - \$40k'),
  //   CViewRecruiters(
  //       id: 1,
  //       designation: 'Product Designer',
  //       experience: '2 - 3 Years',
  //       salary: '\$35k - \$45k'),
  //   CViewRecruiters(
  //       id: 1,
  //       designation: 'Graphic Designer',
  //       experience: '2 - 3 Years',
  //       salary: '\$50k - \$60k'),
  //   CViewRecruiters(
  //       id: 1,
  //       designation: 'UI / UX Designer',
  //       experience: '2 - 3 Years',
  //       salary: '\$60k - \$80k'),
  //   CViewRecruiters(
  //       id: 1,
  //       designation: 'Product Designer',
  //       experience: '2 - 3 Years',
  //       salary: '\$70k - \$90k'),
  //   CViewRecruiters(
  //       id: 1,
  //       designation: 'Graphic Designer',
  //       experience: '2 - 3 Years',
  //       salary: '\$10k - \$20k'),
  // ];

  // List<CViewRecruiters> get items {
  //   return [..._items];
  // }
}
