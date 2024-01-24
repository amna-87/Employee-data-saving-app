import 'package:flutter/material.dart';

class EmployeeDetails extends StatelessWidget {
  final String name;
  final String email;
  final String city;
  final String profession;
  final String imgURL;

  const EmployeeDetails({
    Key? key,
    required this.name,
    required this.email,
    required this.city,
    required this.profession,
    required this.imgURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(imgURL),
            ),
            const SizedBox(height: 20),
            Text('Name: $name'),
            Text('Email: $email'),
            Text('City: $city'),
            Text('Profession: $profession'),
          ],
        ),
      ),
    );
  }
}
