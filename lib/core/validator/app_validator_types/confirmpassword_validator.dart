import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/validator/app_Validator.dart';

class ConfirmPasswordAppValidator extends AppValidator {
  ConfirmPasswordAppValidator({super.initValue});

  String _comparedWithPassword = "";

  set comparedWithPassword(password) {
    _comparedWithPassword = password;
    setValue(value);
  }

  @override
  List<String> check() {
    List<String> reasons = [];

    if (value != _comparedWithPassword) {
      reasons.add(AppStrings.passwordDontMatch);
    }

    return reasons;
  }
}
