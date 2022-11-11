import 'package:email_validator/email_validator.dart';
import 'package:string_validator/string_validator.dart';

class ValidationUtils {
  getEmptyFieldMessage(String field) => 'Por favor, preencha o campo $field';

  bool checkEmail(String email) {
    bool isValid = EmailValidator.validate(email);
    return isValid;
  }

  validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return getEmptyFieldMessage('e-mail');
    } else if (!checkEmail(email)) {
      return 'Formato de e-mail inválido';
    }
  }

  validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return getEmptyFieldMessage("senha");
    } else if (!isAlphanumeric(password)) {
      return 'Sua senha deve conter apenas letras e/ou números';
    } else if (password.length < 6) {
      return 'Sua senha deve conter no mínimo 6 caracteres';
    }
  }
}
