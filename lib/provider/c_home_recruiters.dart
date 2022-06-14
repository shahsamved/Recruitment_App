import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CHomeRecruiters {
  final int id;
  final String companyName;
  final String location;
  final String imageUrl;

  CHomeRecruiters({
    @required this.id,
    @required this.companyName,
    @required this.imageUrl,
    @required this.location,
  });
}

class CHomeRecruitersP with ChangeNotifier {
  String token;
  String urlfront;
  CHomeRecruitersP({this.token, this.urlfront});
  List<CHomeRecruiters> _items = [];
  List<CHomeRecruiters> get items {
    return [..._items];
  }

  Future<void> fetchRecruiters() async {
    final url = 'http://$urlfront/api/auth/getRecruiter/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      final res = json.decode(response.body);
      print('fetch Job positions');
      print(url);
      print(token);
      print(res);
      final List<CHomeRecruiters> _itemList = [];
      res['data'].forEach((f) {
        print("oookkk");
        //print(DateTime.parse(f['created_at'].toString()));
        //print(DateTime.parse(f['created_at'].toString()));
        // print(DateTime.fromMicrosecondsSinceEpoch(
        //     f['created_at'].microsecondsSinceEpoch));
        _itemList.add(CHomeRecruiters(
            id: f['id'],
            companyName: f['name'],
            imageUrl:
                'https://i.pinimg.com/originals/08/5f/d8/085fd8f7819dee3b716da73d3b2de61c.jpg',
            //location: f['Location'],
            location: 'California'));
      });
      print(_itemList);
      _items = _itemList;
      print(res);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  //   CHomeRecruiters(
  //     id: 1,
  //     companyName: 'Google LLC',
  //     imageUrl: 'https://blog.hubspot.com/hubfs/image8-2.jpg',
  //     location: 'Oklahoma, US',
  //     jobPosting: DateTime.now(),
  //   ),
  //   CHomeRecruiters(
  //     id: 2,
  //     companyName: 'Google LLC',
  //     imageUrl: 'https://blog.hubspot.com/hubfs/image8-2.jpg',
  //     location: 'California, US',
  //     jobPosting: DateTime.now(),
  //   ),
  //   CHomeRecruiters(
  //     id: 3,
  //     companyName: 'Amazon',
  //     imageUrl:
  //         'https://i.pinimg.com/originals/08/5f/d8/085fd8f7819dee3b716da73d3b2de61c.jpg',
  //     location: 'Atlantic City, US',
  //     jobPosting: DateTime.now(),
  //   ),
  //   CHomeRecruiters(
  //     id: 4,
  //     companyName: 'Amazon',
  //     imageUrl:
  //         'https://i.pinimg.com/originals/08/5f/d8/085fd8f7819dee3b716da73d3b2de61c.jpg',
  //     location: 'New York, US',
  //     jobPosting: DateTime.now(),
  //   ),
  //   CHomeRecruiters(
  //     id: 5,
  //     companyName: 'Google LLC',
  //     imageUrl: 'https://blog.hubspot.com/hubfs/image8-2.jpg',
  //     location: 'New York, US',
  //     jobPosting: DateTime.now(),
  //   ),
  //   CHomeRecruiters(
  //     id: 6,
  //     companyName: 'Apple',
  //     imageUrl:
  //         'https://cdn-0.idownloadblog.com/wp-content/uploads/2018/07/Apple-logo-black-and-white.png',
  //     location: 'Chicago, US',
  //     jobPosting: DateTime.now(),
  //   ),
  //   CHomeRecruiters(
  //     id: 7,
  //     companyName: 'Apple',
  //     imageUrl:
  //         'https://cdn-0.idownloadblog.com/wp-content/uploads/2018/07/Apple-logo-black-and-white.png',
  //     location: 'Los Angeles, US',
  //     jobPosting: DateTime.now(),
  //   ),
  // ];

}
