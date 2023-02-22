import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/auth/auth_service.dart';
import 'package:tirol_office_mobile_app/view/widget/dialogs.dart';
import 'package:tirol_office_mobile_app/view/widget/snackbars.dart';

import '../../../utils/validation_utils.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    final ValidationUtils validationUtils = ValidationUtils();
    final AuthService authService = AuthService();

    double screenHeight = MediaQuery.of(context).size.height;
    const double horizontalPadding = 50.0;

    SizedBox loginImage() {
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

    Padding emailField() {
      var verticalPadding = (screenHeight / 40);
      var fieldVerticalPadding = 8.0;
      var fieldLeftPadding = 8.0;
      var fieldRightPadding = 0.0;
      return Padding(
        padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding,
            horizontalPadding, fieldVerticalPadding),
        child: TextFormField(
          autofocus: true,
          controller: emailController,
          validator: (value) => validationUtils.validateEmail(value!.trim()),
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

    Widget passwordField() {
      var verticalPadding = (screenHeight / 40);
      var fieldVerticalPadding = 8.0;
      var fieldLeftPadding = 8.0;
      var fieldRightPadding = 0.0;

      return Padding(
        padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding,
            horizontalPadding, fieldVerticalPadding),
        child: Column(
          children: [
            TextFormField(
              obscureText: true,
              controller: passwordController,
              validator: (value) =>
                  validationUtils.validatePassword(value!.trim()),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                filled: true,
                counterStyle: const TextStyle(color: Colors.red),
                hintText: 'Senha',
                contentPadding: EdgeInsets.fromLTRB(
                    fieldLeftPadding,
                    fieldVerticalPadding,
                    fieldRightPadding,
                    fieldVerticalPadding),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget confirmPasswordField() {
      var verticalPadding = (screenHeight / 40);
      var fieldVerticalPadding = 8.0;
      var fieldLeftPadding = 8.0;
      var fieldRightPadding = 0.0;

      return Padding(
        padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding,
            horizontalPadding, verticalPadding),
        child: Column(
          children: [
            TextFormField(
              obscureText: true,
              controller: confirmPasswordController,
              validator: (value) =>
                  validationUtils.validatePassword(value!.trim()),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                filled: true,
                counterStyle: const TextStyle(color: Colors.red),
                hintText: 'Confirme a senha',
                contentPadding: EdgeInsets.fromLTRB(
                    fieldLeftPadding,
                    fieldVerticalPadding,
                    fieldRightPadding,
                    fieldVerticalPadding),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      );
    }

    signin() async {
      if (formKey.currentState!.validate()) {
        if (passwordController.text == confirmPasswordController.text) {
          try {
            await authService.signin(
                emailController.text, passwordController.text);
            SnackBars.showSnackBar(context, 'Usuário cadastrado com sucesso.');
          } catch (e) {
            SnackBars.showSnackBar(
                context, 'Erro ao cadastrar usuário no banco de dados.');
          }
        } else {
          Dialogs.regularDialog(context, 'Formulário inválido.',
              "O campo 'Senha' e o campo 'Confirme  a senha' estão diferentes.");
        }
      }
    }

    Padding submitButton(BuildContext context) {
      var verticalPadding = (screenHeight / 40);
      return Padding(
          padding: EdgeInsets.fromLTRB(
              horizontalPadding, verticalPadding, horizontalPadding, 20),
          child: ElevatedButton(
              onPressed: () => signin(),
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).primaryColor),
              ),
              child: const Text("Enviar")));
    }

    Padding backToLoginScreenButton(BuildContext context) {
      var verticalPadding = (screenHeight / 40);
      return Padding(
          padding: EdgeInsets.fromLTRB(
              horizontalPadding, 10, horizontalPadding, verticalPadding),
          child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.grey),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
              ),
              child: const Text("Voltar")));
    }

    return Scaffold(
        body: Form(
            key: formKey,
            child: ListView(
              children: [
                loginImage(),
                emailField(),
                passwordField(),
                confirmPasswordField(),
                submitButton(context),
                backToLoginScreenButton(context)
              ],
            )));
  }
}
