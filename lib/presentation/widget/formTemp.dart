import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';

class FormTemplate extends StatelessWidget {
  FormTemplate({
    super.key,
    required this.children,
    required this.onSubmit,
    this.submitMessage = "Submit",
    this.enabled = false,
  });
  final List<Widget>? children;
  final VoidCallback onSubmit;
  final String submitMessage;
  final _formGlobalKey = GlobalKey<FormState>();
  final bool enabled;

  Widget validButton() {
    return AppButton(
      onPressed: enabled
          ? () {
              if (_formGlobalKey.currentState?.validate() ?? false) {
                _formGlobalKey.currentState!.save();
                onSubmit();
              }
            }
          : () {},
      backgroundColor: enabled ? AppColors.main : AppColors.grey,
      child: Text(submitMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Column(
        spacing: 10,
        children: <Widget>[
          ...children!.map((e) => e),
          // submit button
          const SizedBox(height: 20),
          validButton(),
        ],
      ),
    );
  }
}
