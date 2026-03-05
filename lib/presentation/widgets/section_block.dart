import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';

class SecBlock extends StatelessWidget {
  const SecBlock({
    super.key,
    required this.title,
    required this.child,
    this.gap = AppSpace.s8,
  });

  final String title;
  final Widget child;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: AppTextStyles.body16),
        SizedBox(height: gap),
        child,
      ],
    );
  }
}
