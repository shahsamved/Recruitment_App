import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CHomeJobs {
  final int id;
  final String companyName;
  final String location;
  final String experience;
  final String designation;
  final DateTime jobPosting;
  final String imageUrl;
  final String salary;
  final String jobdetails;
  final String skills;

  CHomeJobs({
    @required this.id,
    @required this.companyName,
    @required this.imageUrl,
    @required this.location,
    @required this.experience,
    @required this.designation,
    @required this.jobPosting,
    @required this.salary,
    @required this.jobdetails,
    @required this.skills,
  });
}

class CHomeJobsP with ChangeNotifier {
  String token;
  String urlfront;
  CHomeJobsP({this.token, this.urlfront});
  List<CHomeJobs> _items = [];
  List<CHomeJobs> get items {
    return [..._items];
  }

  Future<void> fetchJobPos() async {
    final url = 'http://$urlfront/api/auth/recruiter/viewJobs/';
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
      print('fetch Job positions');
      print(url);
      print(token);
      print(res);
      final List<CHomeJobs> _itemList = [];
      res['data'].forEach((f) {
        print("oookkk");
        //print(DateTime.parse(f['created_at'].toString()));
        //print(DateTime.parse(f['created_at'].toString()));
        // print(DateTime.fromMicrosecondsSinceEpoch(
        //     f['created_at'].microsecondsSinceEpoch));
        _itemList.add(CHomeJobs(
            id: f['id'],
            companyName: f['Client_Name'],
            imageUrl:
                'https://i.pinimg.com/originals/08/5f/d8/085fd8f7819dee3b716da73d3b2de61c.jpg',
            location: f['Location'],
            experience: f['Experience'],
            designation: f['Position'],
            jobPosting: DateTime.parse(f['created_at'].toString()),
            salary: f['salary'],
            jobdetails: f['job_description'],
            skills: f['skills']));
      });
      print(_itemList);
      _items = _itemList;
      print(res);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  // List<CHomeJobs> _items = [
  //   CHomeJobs(
  //       id: 1,
  //       companyName: 'Google LLC',
  //       imageUrl: 'https://blog.hubspot.com/hubfs/image8-2.jpg',
  //       location: 'Oklahoma, US',
  //       experience: '3-5 years',
  //       designation: 'Software Developer',
  //       jobPosting: DateTime.now(),
  //       salary: '\$50k - \$70k'),
  //   CHomeJobs(
  //       id: 2,
  //       companyName: 'Google LLC',
  //       imageUrl: 'https://blog.hubspot.com/hubfs/image8-2.jpg',
  //       location: 'California, US',
  //       experience: '0-2 years',
  //       designation: 'UI - UX designer',
  //       jobPosting: DateTime.now(),
  //       salary: '\$20k - \$50k'),
  //   CHomeJobs(
  //       id: 3,
  //       companyName: 'Amazon',
  //       imageUrl:
  //           'https://i.pinimg.com/originals/08/5f/d8/085fd8f7819dee3b716da73d3b2de61c.jpg',
  //       location: 'Atlantic City, US',
  //       experience: '3-5 years',
  //       designation: 'Software Developer',
  //       jobPosting: DateTime.now(),
  //       salary: '\$30k - \$40k'),
  //   CHomeJobs(
  //       id: 4,
  //       companyName: 'Amazon',
  //       imageUrl:
  //           'https://i.pinimg.com/originals/08/5f/d8/085fd8f7819dee3b716da73d3b2de61c.jpg',
  //       location: 'New York, US',
  //       experience: '10 - 12 years',
  //       designation: 'Senior Full Stack developer',
  //       jobPosting: DateTime.now(),
  //       salary: '\$150k - \$170k'),
  // ];

  // List<CHomeJobs> get items {
  //   return [..._items];
  // }
}
