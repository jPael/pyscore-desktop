import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.label,
      required this.onTap,
      this.startIcon,
      this.endIcon,
      this.type = "primary",
      this.size = "normal",
      this.startWidget,
      this.toolTip});

  final String label;
  final VoidCallback onTap;
  final IconData? startIcon;
  final IconData? endIcon;
  final String? type;
  final String? size;
  final Widget? startWidget;
  final String? toolTip;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> buttonType = {
      "ghost": Colors.white,
      "primary": Theme.of(context).colorScheme.secondary,
      "danger": Colors.red
    };

    Map<String, dynamic> textColorType = {
      "ghost": Colors.black.withOpacity(0.6),
      "primary": Theme.of(context).colorScheme.inversePrimary,
      "danger": Colors.black
    };

    // ignore: no_leading_underscores_for_local_identifiers
    Map<String, dynamic> _size = {"sm": 12, "normal": 14, "md": 18};

    dynamic buttonColor = buttonType[type];
    dynamic textColor = textColorType[type];
    double s = _size[size] + 0.0;

    final bool hasStartWidget = startWidget != null;
    final bool hasStartIcon = startIcon != null;
    final bool hasEndIcon = endIcon != null;

    return Tooltip(
      message: toolTip ?? label,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              backgroundColor: buttonColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
          onPressed: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (hasStartWidget) ...[
                startWidget!,
                const SizedBox(
                  width: 12,
                ),
              ],
              if (hasStartIcon) ...[
                Icon(
                  startIcon,
                  color: textColor,
                  size: s + s / 2,
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
              Text(label, style: TextStyle(color: textColor, fontSize: s)),
              if (hasEndIcon) ...[
                const SizedBox(
                  width: 12,
                ),
                Icon(
                  endIcon,
                  color: textColor,
                  size: s + s / 2,
                ),
              ]
            ],
          )),
    );
  }
}
