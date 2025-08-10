import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/validator/app_Validator.dart';
import 'package:login_signin/core/validator/reg_exp.dart';

class NameValidator extends AppValidator {
  NameValidator({super.initValue});
  @override
  List<String> check() {
    List<String> reasons = [];

    if (value.isEmpty) {
      reasons.add(AppStrings.nameIsValid);
    }
    if (AppRegExp.specialCharacters.hasMatch(value)) {
      reasons.add(AppStrings.nameNotValid);
    }
    if (AppRegExp.numbers.hasMatch(value)) {
      reasons.add(AppStrings.nameNotValid);
    }
    if (AppRegExp.space.hasMatch(value)) {
      reasons.add(AppStrings.nameNotValid);
    }
    return reasons;
  }
}
