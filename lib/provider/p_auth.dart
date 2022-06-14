import 'dart:io';
import 'package:recruitment/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import '../model/httpException.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' show get;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final urlFront = "10.0.2.2:8000";

  String _token;
  int _userId;
  String _name;
  String _email;
  String _password;
  String _phone;
  String _resume;
  String _gender;
  int _statusCode;
  String _rToken;
  int _rid;
  String _rname;
  String _remail;
  String _rpassword;
  String _rphone;
  String _organization;

  bool isVerified = false;
  int get isAuth {
    print("user");
    print(_token);
    if (_token != null)
      return 1;
    else if (_rToken != null)
      return 2;
    else
      return 0;
  }

  bool get isAuth2 {
    print("recruiter");
    print(_rToken);
    return _rToken != null;
  }

  int get user_id {
    return _userId;
  }

  String get token {
    print("in token");
    print(_token);
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get rtoken {
    print("in r token");
    print(_rToken);
    if (_rToken != null) {
      return _rToken;
    }
    return null;
  }

  Future<void> logout() async {
    final url = 'http://$urlFront/api/auth/logout/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(
          {
            'token': _token,
          },
        ),
      );
      final res = json.decode(response.body);
      // notifyListeners();

      print("res=");
      print(res);

      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
    _token = null;
    _userId = null;
    _name = null;
    _email = null;
    _password = null;
    _phone = null;
    _statusCode = null;
    _gender = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<void> otpVerify(String otp, String phone) async {
    final url = 'http://$urlFront/api/auth/verifyOtp/';
    try {
      print(otp);
      print(phone);
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(
          {
            'otp': otp,
            'phone': phone,
          },
        ),
      );
      final res = json.decode(response.body);
      // notifyListeners();
      print("res=");
      print(res);
      _userId = res['data']['id'];
      _token = res['data']['api_token'];
      _phone = res['data']['phone'];
      _name = res['data']['name'];
      _email = res['data']['email'];
      final prefs = await SharedPreferences.getInstance();
      final userdata = json.encode({
        'token': _token,
        'user_id': _userId,
        'phone': _phone,
        'name': _name,
        'email': _email,
      });
      notifyListeners();
      prefs.setString('userData', userdata);
      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> resendOtp() async {
    final url = 'http://$urlFront/api/auth/resendOtp/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(
          {
            'phone': _phone,
          },
        ),
      );
      final res = json.decode(response.body);
      // notifyListeners();
      print("res=");
      print(res);
      // _userId = res['data']['id'];
      // _token = res['data']['api_token'];
      // final prefs = await SharedPreferences.getInstance();
      // final userdata = json.encode({
      //   'token': _token,
      //   'user_id': _userId,
      // });
      // //notifyListeners();
      // prefs.setString('userData', userdata);
      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> userCharges(int charges) async {
    final url = 'http://$urlFront/api/auth/charges/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(
          {
            'id': _userId,
            'charges': charges,
          },
        ),
      );
      final res = json.decode(response.body);
      // notifyListeners();
      print("res=");
      print(res);

      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> getUser() async {
    final url = 'http://$urlFront/api/auth/me/';
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "bearer $_token"
        },
      );
      final res = json.decode(response.body);
      print(res);

      _name = res['name'];
      _email = res['email'];
      _phone = res['phone'];
    } catch (error) {
      throw error;
    }
  }

  User getUserData() {
    //getUser();
    print("in get user data");
    print(_name);

    return User(name: _name, phone: _phone, email: _email);
  }

  Future<void> updateData(
      Map<String, String> updatedData, Map<String, String> data) async {
    print("here in updateData");
    print(updatedData);
    final url = 'http://$urlFront/api/auth/editProfile/';
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "bearer $_token"
        },
        body: json.encode(
          updatedData,
        ),
      );
      final res = json.decode(response.body);
      print(res);

      if (response.statusCode != 200) {
        throw HttpException(res['details']);
      }
      final prefs = await SharedPreferences.getInstance();
      final userdata = json.encode({
        'token': _token,
        'user_id': _userId,
        'phone': data['phone'],
        'name': data['name'],
        'email': data['email']
      });

      print(_token);
      print(_userId);

      prefs.setString('userData', userdata);
      print("done successfull");
    } catch (error) {
      throw error;
    }
  }

  Future<void> register(String fullName, String phone, String email,
      String password, String gender) async {
    final url = 'http://$urlFront/api/auth/register/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          'name': fullName,
          'email': email,
          'phone': phone,
          'Password': password,
          'gender': gender,
          //'photo': photo,
        }),
      );
      final res = json.decode(response.body);
      print(res);

      _userId = res['data']['id'];
      _name = res['data']['name'];
      _email = res['data']['email'];
      _password = res['data']['Password'];
      _phone = res['data']['phone'].toString();
      _gender = res['data']['gender'];
      // final prefs = await SharedPreferences.getInstance();
      // final userdata = json.encode({
      //   'token': _token,
      //   'user_id': _userId,
      //   'name': fullName,
      //   'email': email,
      //   'phone': phone,
      //   'Password': password,
      //   'gender': gender,
      // });
      // //notifyListeners();
      // prefs.setString('userData', userdata);

      // String dir = path.dirname(image.path);
      // print(path.basename(image.path));
      // var temp = path.basename(image.path).split(".")[1];
      // print("temp is sssssss");
      // print(temp);
      // String newPath = path.join(dir, '$user_id.$temp');
      // image.renameSync(newPath);
      // var request = http.MultipartRequest('POST', Uri.parse(url));
      // request.files.add(await http.MultipartFile.fromPath('image', newPath));
      // request.headers['Authorization'] = "Token $token";
      // var res = await request.send();

      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<bool> autoLogin() async {
    print("auto login");
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData') && !prefs.containsKey('rData')) {
      return false;
    }
    if (prefs.containsKey('userData')) {
      print('ok');
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      _userId = extractedUserData['user_id'];
      _token = extractedUserData['token'];
      _phone = extractedUserData['phone'];
      _email = extractedUserData['email'];
      _name = extractedUserData['name'];
      print("auto login");
      print(_token);
      notifyListeners();
      return true;
    } else {
      print('recruiter ok');
      final extractedrData =
          json.decode(prefs.getString('rData')) as Map<String, Object>;
      _rid = extractedrData['recruiter_id'];
      _rToken = extractedrData['token'];

      print("auto login 2");
      print(_rToken);
      notifyListeners();
      return true;
    }
  }

  Future<void> login(String phone, String password) async {
    final url = 'http://$urlFront/api/auth/login/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          'phone': phone,
          'password': password,
        }),
      );
      final res = json.decode(response.body);
      print(res);
      _userId = res['data']['id'];
      _name = res['data']['name'];
      _email = res['data']['email'];
      _password = res['data']['Password'];
      _phone = res['data']['phone'].toString();
      _gender = res['data']['gender'];
      _token = res['data']['api_token'];

      final prefs = await SharedPreferences.getInstance();
      final userdata = json.encode({
        'token': _token,
        'user_id': _userId,
        'phone': phone,
        'password': password,
        'name': _name,
        'email': _email
      });
      print("In login");
      print(_token);
      notifyListeners();
      prefs.setString('userData', userdata);
      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> complete_profile(
      String Education,
      String CurrentPosition,
      String CurrentIndustry,
      String TotalWorkExperience,
      String LastWorkingMonth,
      String CurrentLocation,
      String LastDrawnSalary) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _userId = extractedUserData['user_id'];
    final url = 'http://$urlFront/api/auth/userprofile/';
    try {
      print("user id=");
      print(_userId);
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          'id': _userId,
          'Education': Education,
          'Current_Position': CurrentPosition,
          'Current_Industry': CurrentIndustry,
          'Total_Work_Experience': TotalWorkExperience,
          'Last_Working_Month': LastWorkingMonth,
          'Current_Location': CurrentLocation,
          'Last_Drawn_Salary': LastDrawnSalary,

          //'photo': photo,
        }),
      );
      final res = json.decode(response.body);
      print(res);
      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> rlogout() async {
    final url = 'http://$urlFront/api/auth/logout/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(
          {
            'token': _rToken,
          },
        ),
      );
      final res = json.decode(response.body);
      // notifyListeners();
      print("res=");
      print(res);

      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
    _rToken = null;
    _rid = null;
    _rname = null;
    _remail = null;
    _rpassword = null;
    _rphone = null;
    _organization = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<void> rotpVerify(String otp, String phone) async {
    final url = 'http://$urlFront/api/auth/recruiter/verifyOtp/';
    try {
      print("ok");
      print(otp);
      print(phone);
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(
          {
            'otp': otp,
            'phone': phone,
          },
        ),
      );
      print("ok2");
      final res = json.decode(response.body);
      // notifyListeners();
      print("res=");
      print(res);
      _rid = res['data']['id'];
      _rToken = res['data']['api_token'];
      _rphone = res['data']['phone'];
      _rname = res['data']['name'];
      _remail = res['data']['email'];
      final prefs = await SharedPreferences.getInstance();
      final rdata = json.encode({
        'token': _rToken,
        'recruiter_id': _rid,
        'phone': _rphone,
        'name': _rname,
        'email': _remail,
      });
      notifyListeners();
      prefs.setString('rData', rdata);
      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> rresendOtp() async {
    final url = 'http://$urlFront/api/auth/recruiter/resendOtp/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(
          {
            'phone': _rphone,
          },
        ),
      );
      final res = json.decode(response.body);
      // notifyListeners();
      print("res=");
      print(res);
      // _userId = res['data']['id'];
      // _token = res['data']['api_token'];
      // final prefs = await SharedPreferences.getInstance();
      // final userdata = json.encode({
      //   'token': _token,
      //   'user_id': _userId,
      // });
      // //notifyListeners();
      // prefs.setString('userData', userdata);
      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> recruiterCharges(int charges) async {
    final url = 'http://$urlFront/api/auth/recruiter/charges/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(
          {
            'id': _rid,
            'charges': charges,
          },
        ),
      );
      final res = json.decode(response.body);
      // notifyListeners();
      print("res=");
      print(res);

      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> rregister(String name, String phone, String email,
      String password, String organization) async {
    final url = 'http://$urlFront/api/auth/recruiter/register/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'organization': organization,
          //'photo': photo,
        }),
      );
      final res = json.decode(response.body);
      print(res);
      _rid = res['data']['id'];
      _rname = res['data']['name'];
      _remail = res['data']['email'];
      _rpassword = res['data']['password'];
      _rphone = res['data']['phone'].toString();
      _organization = res['data']['organization'];
      // final prefs = await SharedPreferences.getInstance();
      // final rdata = json.encode({
      //   'token': _rToken,
      //   'recruiter_id': _rid,
      //   'name': name,
      //   'email': email,
      //   'phone': phone,
      //   'password': password,
      //   'organization': organization,
      // });
      // //notifyListeners();
      // prefs.setString('rData', rdata);

      // String dir = path.dirname(image.path);
      // print(path.basename(image.path));
      // var temp = path.basename(image.path).split(".")[1];
      // print("temp is sssssss");
      // print(temp);
      // String newPath = path.join(dir, '$user_id.$temp');
      // image.renameSync(newPath);
      // var request = http.MultipartRequest('POST', Uri.parse(url));
      // request.files.add(await http.MultipartFile.fromPath('image', newPath));
      // request.headers['Authorization'] = "Token $token";
      // var res = await request.send();

      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> rlogin(String phone, String password) async {
    final url = 'http://$urlFront/api/auth/recruiter/login/';
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          'phone': phone,
          'password': password,
        }),
      );
      final res = json.decode(response.body);
      print(res);
      _rid = res['data']['id'];
      _rToken = res['data']['api_token'];
      final prefs = await SharedPreferences.getInstance();
      final rdata = json.encode({
        'token': _rToken,
        'recruiter_id': _rid,
      });
      print("In recruiter login");
      print(_rToken);
      notifyListeners();
      prefs.setString('rData', rdata);
      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> rcomplete_profile(
    String contactPerson,
    String city,
    String state,
    String industry,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('rData')) {
      return false;
    }
    final extractedrData =
        json.decode(prefs.getString('rData')) as Map<String, Object>;
    _rid = extractedrData['recruiter_id'];
    final url = 'http://$urlFront/api/auth/recruiterprofile/';
    try {
      print("recruiter id=");
      print(_rid);
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          'id': _rid,
          'Contact_Person': contactPerson,
          'City': city,
          'State': state,
          'Industry': industry
        }),
      );
      final res = json.decode(response.body);
      print(res);
      if (res['status_code'] != 200) {
        throw HttpException(res['details']);
      }
    } catch (error) {
      throw error;
    }
  }
}
