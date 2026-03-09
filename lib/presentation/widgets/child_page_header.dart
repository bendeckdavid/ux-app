import 'child_icon_button.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/app_text_styles.dart';

class PgHead extends StatelessWidget {
  const PgHead({super.key, required this.onBack, this.title});

  final VoidCallback onBack;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        BackBtn(onTap: onBack),
        if (title != null) ...<Widget>[
          const SizedBox(width: AppSpace.s8),
          Text(title!, style: AppTextStyles.title22),
        ],
      ],
    );
  }
}

class BackBtn extends StatelessWidget {
  const BackBtn({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IBtn(icon: Icons.arrow_back, onTap: onTap, circular: true);
  }
}
