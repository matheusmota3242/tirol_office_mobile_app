import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/auth/auth_service.dart';
import 'package:tirol_office_mobile_app/utils/validation_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final ValidationUtils _validationUtils = ValidationUtils();
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email, _password;

  static const double _horizontalPadding = 50.0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            _loginImage(screenHeight),
            _emailField(screenHeight),
            _passwordField(screenHeight),
            _submitButton(context, screenHeight)
          ],
        ),
      ),
    );
  }

  SizedBox _loginImage(double screenHeight) {
    double imageHeight = 120.0;
    double paddingTop = (screenHeight / 12);
    double paddingBottom = (screenHeight / 15);
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
        child: Image.asset('assets/images/logo.png', height: imageHeight),
      ),
    );
  }

  Padding _emailField(double screenHeight) {
    var verticalPadding = (screenHeight / 40);
    var fieldVerticalPadding = 8.0;
    var fieldLeftPadding = 8.0;
    var fieldRightPadding = 0.0;
    return Padding(
      padding: EdgeInsets.fromLTRB(_horizontalPadding, verticalPadding,
          _horizontalPadding, verticalPadding),
      child: TextFormField(
        onChanged: (value) => _email = value.trim(),
        validator: (value) => _validationUtils.validateEmail(value),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(fieldLeftPadding,
              fieldVerticalPadding, fieldRightPadding, fieldVerticalPadding),
          hintText: 'E-mail',
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _passwordField(double screenHeight) {
    double verticalPadding = (screenHeight / 40);
    double topPadding = 8.0, leftPadding = 8.0;
    double rightPadding = 0.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          _horizontalPadding, verticalPadding, _horizontalPadding, 0.0),
      child: Column(
        children: [
          TextFormField(
            obscureText: true,
            onChanged: (value) => _password = value.trim(),
            validator: (value) => _validationUtils.validatePassword(value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              filled: true,
              counterStyle: const TextStyle(color: Colors.red),
              hintText: 'Senha',
              contentPadding: EdgeInsets.fromLTRB(
                  leftPadding, topPadding, rightPadding, topPadding),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _submitButton(BuildContext context, double screenHeight) {
    var verticalPadding = (screenHeight / 40);
    return Padding(
        padding: EdgeInsets.fromLTRB(_horizontalPadding, verticalPadding,
            _horizontalPadding, verticalPadding),
        child: ElevatedButton(
            onPressed: () => login(context),
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Theme.of(context).primaryColor),
            ),
            child: const Text("Enviar")
            // child: RaisedButton(
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            //   onPressed: () {
            //     login(context, authService);
            //   },
            //   child: Text(
            //     'Entrar',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            //   color: Theme.of(context).buttonColor,
            //   padding: EdgeInsets.only(top: buttonPadding, bottom: buttonPadding),
            // ),
            ));
  }

  Future login(BuildContext context) async {
    await _authService.login(_email, _password);
  }
}
