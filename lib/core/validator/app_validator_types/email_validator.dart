import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/validator/app_Validator.dart';
import 'package:login_signin/core/validator/reg_exp.dart';

class EmailAppValidator extends AppValidator {
  EmailAppValidator({super.initValue});
  @override
  List<String> check() {
    List<String> reasons = [];

    if (value.isEmpty) {
      reasons.add(AppStrings.emailIsValid);
    }
    if (!AppRegExp.email.hasMatch(value)) {
      reasons.add(AppStrings.emailNotValid);
    }
    return reasons;
  }
}
