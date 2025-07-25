import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';

class FormTemplate extends StatefulWidget {
  const FormTemplate({
    super.key,
    required this.children,
    required this.onSubmit,
    this.submitMessage = "Submit",
  });
  final List<Widget>? children;
  final VoidCallback onSubmit;
  final String submitMessage;

  @override
  State<FormTemplate> createState() => _FormTemplateState();
}

class _FormTemplateState extends State<FormTemplate> {
  final _formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...widget.children!.map((e) => Card(child: e)),
          // submit button
          const SizedBox(height: 20),
          AppButton(
            backgroundColor: AppColors.main,
            onPressed: () {
              if (_formGlobalKey.currentState!.validate()) {
                _formGlobalKey.currentState!.save();
                widget.onSubmit();
              }
            },
            child: Text(widget.submitMessage),
          ),
        ],
      ),
    );
  }
}
