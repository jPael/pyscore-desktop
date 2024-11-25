import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.startIcon,
    this.endIcon,
    this.type = "primary",
  });

  final String label;
  final VoidCallback onTap;
  final IconData? startIcon;
  final IconData? endIcon;
  final String? type;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> buttonType = {
      "ghost": Colors.white,
      "primary": Theme.of(context).colorScheme.secondary,
      "danger": Colors.red
    };

    Map<String, dynamic> textColorType = {
      "ghost": Theme.of(context).colorScheme.primary,
      "primary": Theme.of(context).colorScheme.inversePrimary,
      "danger": Colors.black
    };

    dynamic buttonColor = buttonType[type];
    dynamic textColor = textColorType[type];

    final bool hasStartIcon = startIcon != null;
    final bool hasEndIcon = endIcon != null;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            backgroundColor: buttonColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))),
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (hasStartIcon) ...[
              Icon(
                startIcon,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(
                width: 12,
              ),
            ],
            Text(label,
                style: TextStyle(
                  color: textColor,
                )),
            if (hasEndIcon) ...[
              const SizedBox(
                width: 12,
              ),
              Icon(
                endIcon,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ]
          ],
        ));
  }
}
