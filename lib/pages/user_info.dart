import 'package:flutter/material.dart';
import 'package:kamilla/models/user.dart';

class UserInfoPage extends StatelessWidget {
  final User userInfo;

  const UserInfoPage({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text(userInfo.name),
              leading: Icon(
                Icons.person,
                color: Colors.pink,
              ),
            ),
            ListTile(
              title: Text(userInfo.phoneNumber),
              leading: Icon(
                Icons.phone,
                color: Colors.pink,
              ),
            ),
            ListTile(
              title: Text(userInfo.email),
              leading: Icon(
                Icons.mail,
                color: Colors.pink,
              ),
            ),
            ListTile(
              title: Text(userInfo.country),
              leading: Icon(
                Icons.map,
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
