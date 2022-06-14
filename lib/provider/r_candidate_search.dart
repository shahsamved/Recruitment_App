import 'package:flutter/foundation.dart';

class RCandidateSearch {
  final int id;
  final String name;
  final String location;
  final String experience;
  final String imageURL;

  RCandidateSearch(
      {@required this.id,
      @required this.name,
      @required this.location,
      @required this.experience,
      @required this.imageURL});
}

class RCandidateSearchP with ChangeNotifier {
  List<RCandidateSearch> _items = [
    RCandidateSearch(
        id: 1,
        name: 'Tony Stark',
        location: 'Eaglewood, Colorado',
        experience: '3 years',
        imageURL:
            'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/121004580/original/bf1141617acf0153b0420bb2e24a6fb9c239f726/create-a-vector-image-for-a-profile-picture.jpg'),
    RCandidateSearch(
        id: 2,
        name: 'Bruce Banner',
        location: 'Eaglewood, Colorado',
        experience: '3 years',
        imageURL:
            'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/121004580/original/bf1141617acf0153b0420bb2e24a6fb9c239f726/create-a-vector-image-for-a-profile-picture.jpg'),
    RCandidateSearch(
        id: 3,
        name: 'Steve Rogers',
        location: 'Eaglewood, Colorado',
        experience: '3 years',
        imageURL:
            'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/121004580/original/bf1141617acf0153b0420bb2e24a6fb9c239f726/create-a-vector-image-for-a-profile-picture.jpg'),
    RCandidateSearch(
        id: 4,
        name: 'Sam Wilson',
        location: 'Eaglewood, Colorado',
        experience: '3 years',
        imageURL:
            'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/121004580/original/bf1141617acf0153b0420bb2e24a6fb9c239f726/create-a-vector-image-for-a-profile-picture.jpg'),
    RCandidateSearch(
        id: 5,
        name: 'Thor Odinson',
        location: 'Eaglewood, Colorado',
        experience: '3 years',
        imageURL:
            'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/121004580/original/bf1141617acf0153b0420bb2e24a6fb9c239f726/create-a-vector-image-for-a-profile-picture.jpg'),
  ];

  List<RCandidateSearch> get items {
    return [..._items];
  }
}
