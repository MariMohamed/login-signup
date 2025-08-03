import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/utils/utils.dart';
import 'package:login_signin/core/validator/app_Validator.dart';

class PhoneAppValidator extends AppValidator {
  String get formatedPhoneNumberWithCountryCode =>
      Utils.getFormattedPhoneNumberWithCountryCode("EG", value);

  PhoneAppValidator({super.initValue});

  @override
  List<String> check() {
    List<String> reasons = [];

    if (value.isEmpty) {
      reasons.add(AppStrings.requiredField);
    }

    if (!Utils.isPhoneNumberIsValidWithCountyCode("EG", value)) {
      reasons.add(AppStrings.invalidPhone);
    }

    return reasons;
  }
}
