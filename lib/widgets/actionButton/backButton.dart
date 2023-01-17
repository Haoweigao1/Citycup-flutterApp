import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key, required BuildContext context})
      : _buildContext = context,
        super(key: key);

  final BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    return BackButton(onPressed: () {
      Navigator.pop(_buildContext);
    });
  }
}
