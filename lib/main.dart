import 'package:flutter/material.dart';
import 'package:kamilla/pages/register_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ValidationForm());
}

class ValidationForm extends StatelessWidget {
  const ValidationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registration Form',
      theme: ThemeData(),
      home: const RegisterFormPage(),
    );
  }
}
