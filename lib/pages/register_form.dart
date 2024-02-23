import 'package:flutter/material.dart';
import 'package:kamilla/models/user.dart';
import 'user_info.dart';
import 'dart:developer';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  _RegisterFormPage createState() => _RegisterFormPage();
}

class _RegisterFormPage extends State<RegisterFormPage> {
  bool _hidePass = true;

  User newUser = User();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final List<String> _countries = ['Казахстан', 'Россия', 'США', 'Корея'];
  String _selectedCountry = 'Казахстан';

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Validation Form'),
          backgroundColor: Color.fromARGB(255, 243, 210, 224),
        ),
        backgroundColor: Color.fromARGB(255, 243, 210, 224),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Привет!",
                    style: TextStyle(fontSize: 20, color: Colors.pink),
                  ),
                  Text(
                    "Зарегистрируйся здесь",
                    style: TextStyle(fontSize: 20, color: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Введите свое имя"),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return "Введите корректное имя";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) => newUser.name = newValue!,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration:
                        InputDecoration(labelText: "Введите свой номер"),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^\(\d{3}\)\d{3}\-\d{4}$').hasMatch(value)) {
                        return "Введите корректный номер";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) => newUser.phoneNumber = newValue!,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration:
                        InputDecoration(labelText: "Введите свой email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      } else if (!value.contains('@')) {
                        return 'Invalid email address';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) => newUser.email = newValue!,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Password *',
                      hintText: 'Create password',
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(_hidePass
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _hidePass = !_hidePass;
                          });
                        },
                      ),
                    ),
                    validator: validatePassword,
                    obscureText: _hidePass,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _hidePass,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password *',
                      hintText: 'Confirm the password',
                      icon: Icon(Icons.border_color),
                    ),
                    validator: validatePassword,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.map),
                        labelText: 'Country'),
                    items: _countries.map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (country) {
                      setState(() {
                        _selectedCountry = country as String;
                        newUser.country = country;
                      });
                    },
                    value: _selectedCountry,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Submit",
                        style: TextStyle(fontSize: 22, color: Colors.pink),
                      ),
                      IconButton(
                        onPressed: _submitForm,
                        icon: Icon(Icons.arrow_forward),
                        iconSize: 50,
                        color: Colors.pink,
                        padding: EdgeInsets.all(16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      log('Name: ${_nameController.text}');
      log('Phone Number: ${_phoneNumberController.text}');
      log('Email: ${_emailController.text}');
      log('Country: $_selectedCountry');
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
    }
  }

  String? validatePassword(String? value) {
    if (_passwordController.text.length != 10) {
      return '10 character required for password';
    } else if (_confirmPasswordController.text != _passwordController.text) {
      return 'Password doesnt match';
    } else {
      return null;
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
        ),
      ),
    ));
  }

  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Registration successful',
            style: TextStyle(
              color: Colors.pink,
            ),
          ),
          content: Text(
            '$name is now a verified register form',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage(
                      userInfo: newUser,
                    ),
                  ),
                );
              },
              child: const Text(
                'Verified',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
