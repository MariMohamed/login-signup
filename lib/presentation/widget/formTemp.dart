import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';

class FormTemplate extends StatelessWidget {
  FormTemplate({
    super.key,
    required this.children,
    required this.onSubmit,
    this.submitMessage = "Submit",
  });
  final List<Widget>? children;
  final VoidCallback onSubmit;
  final String submitMessage;
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: <Widget>[
          ...children!.map((e) => e),
          // submit button
          const SizedBox(height: 20),
          AppButton(
            onPressed: () {
              if (_formGlobalKey.currentState!.validate()) {
                _formGlobalKey.currentState!.save();
                onSubmit();
              }
            },
            child: Text(submitMessage),
          ),
        ],
      ),
    );
  }
}
