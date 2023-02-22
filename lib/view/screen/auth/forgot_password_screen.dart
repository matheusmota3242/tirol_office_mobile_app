import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/view/widget/snackbars.dart';

import '../../../auth/auth_service.dart';
import '../../../exception/bad_form_exception.dart';
import '../../../utils/validation_utils.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ValidationUtils validationUtils = ValidationUtils();
    final AuthService authService = AuthService();

    double screenHeight = MediaQuery.of(context).size.height;
    const double horizontalPadding = 50.0;

    var emailController = TextEditingController();

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

    sendChangeEmailPassword() async {
      if (formKey.currentState!.validate()) {
        try {
          await authService.sendChangePasswordEmail(emailController.text);
          SnackBars.showSnackBar(context, 'Email enviado com sucesso.');
        } on BadFormException {
          SnackBars.showSnackBar(
              context, 'Erro ao enviar email para alteração de senha.');
        }
      }
    }

    Padding submitButton(BuildContext context) {
      var verticalPadding = (screenHeight / 40);
      return Padding(
          padding: EdgeInsets.fromLTRB(
              horizontalPadding, verticalPadding, horizontalPadding, 20),
          child: ElevatedButton(
              onPressed: () => sendChangeEmailPassword(),
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
                submitButton(context),
                backToLoginScreenButton(context)
              ],
            )));
  }
}
