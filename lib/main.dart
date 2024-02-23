import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Định nghĩa các lớp mô hình
class Province {
  final String id;
  final String name;
  final String level;

  Province({required this.id, required this.name, required this.level});

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      level: map['level'] ?? '',
    );
  }
}

class District {
  final String id;
  final String name;
  final String level;
  final String provinceId;

  District({required this.id, required this.name, required this.level, required this.provinceId});

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      level: map['level'] ?? '',
      provinceId: map['provinceId'] ?? '',
    );
  }
}

class Ward {
  final String id;
  final String name;
  final String level;
  final String districtId;
  final String provinceId;

  Ward({required this.id, required this.name, required this.level, required this.districtId, required this.provinceId});

  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      level: map['level'] ?? '',
      districtId: map['districtId'] ?? '',
      provinceId: map['provinceId'] ?? '',
    );
  }
}

class AddressInfo {
  final Province? province;
  final District? district;
  final Ward? ward;
  final String? street;

  AddressInfo({this.province, this.district, this.ward, this.street});

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      province: Province.fromMap(map['province']),
      district: District.fromMap(map['district']),
      ward: Ward.fromMap(map['ward']),
      street: map['street'],
    );
  }
}

class UserInfo {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final DateTime? birthDate;
  final AddressInfo? address;

  UserInfo({this.name, this.email, this.phoneNumber, this.birthDate, this.address});

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      birthDate: DateTime.parse(map['birthDate'] ?? ''),
      address: AddressInfo.fromMap(map['address']),
    );
  }
}

// Định nghĩa giao diện người dùng
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Information',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'User Information'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Khởi tạo dữ liệu
  // Khởi tạo dữ liệu
  UserInfo? userInfo = UserInfo(
    name: 'lê bá minh an',
    email: 'minhan@gmail.com',
    phoneNumber: '09999999',
    birthDate: DateTime.parse('2003-01-19'),
    address: AddressInfo(
      province: Province(id: '1', name: 'hà nội', level: 'thành pố trung ương'),
      district: District(id: '003', name: 'quận tây hồ', level: 'quận', provinceId: '1'),
      ward: Ward(id: '00103', name: 'phường xuân la', level: 'phường', districtId: '003', provinceId: '1'),
      street: 'Võ Chí Công',
    ),
  );

  AddressInfo? addressInfo = AddressInfo(
    province: Province(id: '1', name: 'hà nội', level: 'thành pố trung ương'),
    district: District(id: '003', name: 'quận tây hồ', level: 'quận', provinceId: '1'),
    ward: Ward(id: '00103', name: 'phường xuân la', level: 'phường', districtId: '003', provinceId: '1'),
    street: 'Võ Chí Công',
  );

  void showUserInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Information'),
          content: Text('Name: ${userInfo?.name}\n'
              'Email: ${userInfo?.email}\n'
              'Phone Number: ${userInfo?.phoneNumber}\n'
              'Birth Date: ${userInfo?.birthDate}\n'
              'Street: ${userInfo?.address?.street}\n'
              'Ward: ${userInfo?.address?.ward?.name}\n'
              'District: ${userInfo?.address?.district?.name}\n'
              'Province: ${userInfo?.address?.province?.name}'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showAddressInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Address Information'),
          content: Text('Street: ${addressInfo?.street}\n'
              'Ward: ${addressInfo?.ward?.name}\n'
              'District: ${addressInfo?.district?.name}\n'
              'Province: ${addressInfo?.province?.name}'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'User Information:',
            ),
            ElevatedButton(
              onPressed: showUserInfo,
              child: Text('Show UserInfo'),
            ),
            ElevatedButton(
              onPressed: showAddressInfo,
              child: Text('Show AddressInfo'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
