import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../providers/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:device_info/device_info.dart';

class Register extends StatefulWidget {
  Register();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  String errorMessage = '';
  late String deviceName;

  @override
  void initState() {
    super.initState();
    getDeviceName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        backgroundColor: Color(0xFFEE8B60),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Card(
              elevation: 8,
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Votre nom';
                          }

                          return null;
                        },
                        onChanged: (text) => setState(() => errorMessage = ''),
                        decoration: InputDecoration(
                          labelText: 'Nom',
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Votre email';
                          }

                          return null;
                        },
                        onChanged: (text) => setState(() => errorMessage = ''),
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: passwordController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Votre mot de passe';
                          }

                          return null;
                        },
                        onChanged: (text) => setState(() => errorMessage = ''),
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: passwordConfirmController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Confirmer le mot de passe';
                          }

                          return null;
                        },
                        onChanged: (text) => setState(() => errorMessage = ''),
                        decoration: InputDecoration(
                            labelText: 'Confirmer le mot de passe'),
                      ),
                      ElevatedButton(
                        onPressed: () => submit(),
                        child: Text('Inscription'),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFFEE8B60),
                            onPrimary: Colors.white,
                            minimumSize: Size(double.infinity, 36)),
                      ),
                      Text(errorMessage, style: TextStyle(color: Colors.red)),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text('<- Déjà inscrit ?',
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> submit() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    final AuthProvider provider =
        Provider.of<AuthProvider>(context, listen: false);
    try {
      await provider.register(nameController.text, emailController.text,
          passwordController.text, passwordConfirmController.text, deviceName);

      Navigator.pop(context);
    } catch (Exception) {
      setState(() {
        errorMessage = Exception.toString().replaceAll('Exception: ', '');
      });
    }
  }

  Future<void> getDeviceName() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = build.model;
        });
      } else if (Platform.isIOS) {
        var build = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceName = build.model;
        });
      }
    } on PlatformException {
      setState(() {
        deviceName = 'Failed to get platform version';
      });
    }
  }
}
