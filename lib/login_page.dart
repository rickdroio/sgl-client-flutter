import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:sgl_app_flutter/components/edit_text.dart';
import 'package:sgl_app_flutter/services/app/auth.service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final authService = GetIt.I.get<AuthService>();

  @override
  void initState() {
    super.initState();
    // Register the callback for keyboard events
    //RawKeyboard.instance.addListener(handleKeyEvent);
  }

  @override
  void dispose() {
    //RawKeyboard.instance.removeListener(handleKeyEvent);
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Row(children: [
          Center(child: Image.asset('images/login.jpg')),
          Expanded(child: loginForm())
        ])));
  }

  Widget loginForm() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Icon(
            Icons.lock,
            size: 100,
          ),
          const SizedBox(height: 50),
          Text('Sistema Gerenciamento Lojas',
              style: TextStyle(color: Colors.grey[700], fontSize: 18)),
          const SizedBox(height: 50),
          Form(
              key: _formKey,
              onChanged: () => setState(() {
                    isFormValid = _formKey.currentState!.validate();
                  }),
              child: Column(children: [
                EditText(
                    label: 'Email',
                    hint: "e-mail",
                    controller: emailController,
                    fieldType: EditTextType.email),
                EditText(
                    label: 'Senha',
                    hint: "senha",
                    controller: passwordController,
                    fieldType: EditTextType.password),
              ])),
          const SizedBox(height: 50),
          FilledButton(
              onPressed: (isFormValid) ? submitForm : null,
              child: const Text('Entrar')),
        ],
      ),
    );
  }

  void submitForm() async {
    var email = emailController.text;
    var password = passwordController.text;

    authService.login(email, password);
    //print(authService.isLogged);

    //UserController().login(email, password);

    /*
    var data = jsonEncode(<String, String> {'email': email, 'password': password});
    var response = await HttpService(context).post('http://localhost:3000/auth/login', data);

    if (response.isNotEmpty) {
      final String accessToken = response['access_token'];
      authService.setLoggedIn(status: true, token: accessToken);
    }
    */
  }

  void handleKeyEvent(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      submitForm();
    }
  }

/*
  void showAlertDialog(String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            FilledButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }    
*/
}
