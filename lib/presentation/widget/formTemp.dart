import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';

class FormTemplate extends StatefulWidget {
  const FormTemplate({
    super.key,
    required this.children,
    required this.onSubmit,
    this.submitMessage = "Submit",
    this.enabled = false,
  });
  final List<Widget>? children;
  final VoidCallback onSubmit;
  final String submitMessage;
  final bool enabled;

  @override
  State<FormTemplate> createState() => _FormTemplateState();
}

class _FormTemplateState extends State<FormTemplate>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _formGlobalKey = GlobalKey<FormState>();

  Widget validButton() {
    return AppButton(
      onPressed: widget.enabled
          ? () {
              if (_formGlobalKey.currentState?.validate() ?? false) {
                _formGlobalKey.currentState!.save();
                widget.onSubmit();
              }
            }
          : () {},
      backgroundColor: widget.enabled ? AppColors.main : AppColors.grey,
      title: widget.submitMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Column(
        spacing: 10,
        children: <Widget>[
          ...widget.children!.map((e) => e),
          // submit button
          const SizedBox(height: 20),
          validButton(),
        ],
      ),
    );
  }
}
