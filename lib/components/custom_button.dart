import 'package:pyscore/constants/types/custom_button_type.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.label,
      required this.onTap,
      this.startIcon,
      this.endIcon,
      this.type = CustomButtonType.primary,
      this.size = CustomButtonSize.normal,
      this.startWidget,
      this.toolTip,
      this.isLoading = false,
      this.padding,
      this.isDisabled = false});

  final String label;
  final VoidCallback onTap;
  final IconData? startIcon;
  final IconData? endIcon;
  final CustomButtonType? type;
  final CustomButtonSize? size;
  final Widget? startWidget;
  final String? toolTip;
  final bool? isLoading;
  final EdgeInsetsGeometry? padding;
  final bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    Map<CustomButtonType, dynamic> buttonType = {
      CustomButtonType.ghost: Colors.white,
      CustomButtonType.primary: Theme.of(context).colorScheme.secondary,
      CustomButtonType.danger: Colors.red[800]
    };

    Map<CustomButtonType, dynamic> textColorType = {
      CustomButtonType.ghost: Colors.black.withValues(alpha: 0.6),
      CustomButtonType.primary: Theme.of(context).colorScheme.inversePrimary,
      CustomButtonType.danger: Colors.white
    };

    // ignore: no_leading_underscores_for_local_identifiers
    Map<CustomButtonSize, dynamic> _size = {
      CustomButtonSize.sm: 12,
      CustomButtonSize.normal: 14,
      CustomButtonSize.md: 18,
      CustomButtonSize.lg: 24
    };

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
              padding: padding ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              backgroundColor: buttonColor,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
          onPressed: isDisabled! || isLoading == null || isLoading == true ? null : onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isLoading!) ...[
                SizedBox(
                  height: s,
                  width: s,
                  child: CircularProgressIndicator(
                    color: textColorType[CustomButtonType.danger],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
              ] else if (hasStartWidget && !isLoading!) ...[
                startWidget!,
                const SizedBox(
                  width: 12,
                ),
              ] else if (hasStartIcon && !isLoading!) ...[
                Icon(
                  startIcon,
                  color: textColor,
                  size: s + s / 2,
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
              Text(
                label,
                style: TextStyle(color: textColor, fontSize: s),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
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
