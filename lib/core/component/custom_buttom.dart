import 'package:flutter/material.dart';
import 'package:smartnote/utils/theme/theme.dart';

typedef void Callback();

class CustomButton extends StatelessWidget {
  final Icon? icon;
  final CustomButtonType type;
  final Widget? child;
  final String? text;
  final Callback? onPressed;
  final double? height;
  final Color? color;
  final Gradient? gradient;
  final bool showProgressIndicator;

  /// Specifies whether the text within the button should wrap onto multiple
  /// lines if the button width is too small. Set this to false if using the
  /// button inside a parent that doesn't provide width constraints. (Otherwise
  /// an error will occur during layout.)
  final bool wrapText;

  CustomButton({
    Key? key,
    CustomButtonType? type = CustomButtonType.standard,
    this.icon,
    this.child,
    this.text,
    this.onPressed,
    this.height = 60.0,
    this.color,
    this.gradient,
    this.showProgressIndicator = false,
    this.wrapText = true,
  })  : this.type = type ?? CustomButtonType.standard,
        super(key: key);

  /// Create a button with a smaller height for use in places such as the app bar.
  /// Note: the button will take as much width as required for the content and
  /// will not wrap text.
  factory CustomButton.small({
    Key? key,
    CustomButtonType? type,
    Icon? icon,
    Widget? child,
    String? text,
    Callback? onPressed,
    Color? color,
    Gradient? gradient,
    bool showProgressIndicator = false,
  }) {
    return CustomButton(
      type: type,
      height: 34,
      icon: icon,
      text: text,
      onPressed: onPressed,
      color: color,
      gradient: gradient,
      showProgressIndicator: showProgressIndicator,
      wrapText: false,
      key: key,
    );
  }

  factory CustomButton.primaryGradient({
    Key? key,
    Icon? icon,
    Widget? child,
    String? text,
    Callback? onPressed,
    double? height,
    bool showProgressIndicator = false,
    bool wrapText = true,
  }) {
    return CustomButton(
      icon: icon,
      child: child,
      onPressed: onPressed,
      gradient: LinearGradient(
        colors: [
          CustomColors.primaryGradient.color1,
          CustomColors.primaryGradient.color2,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      height: height,
      showProgressIndicator: showProgressIndicator,
      wrapText: wrapText,
    );
  }

  Widget _buildCustomButtonType(
      Container contents, CustomButtonType customButtonType, ThemeData theme) {
    switch (customButtonType) {
      case CustomButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CustomBorderRadius.medium),
            ),
            side: BorderSide(
                width: 2,
                color: color == null ? theme.colorScheme.error : color!),
          ),
          child: (gradient != null)
              ? Ink(
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius:
                        BorderRadius.circular(CustomBorderRadius.medium),
                  ),
                  child: contents,
                )
              : contents,
        );
      case CustomButtonType.standard:
      default:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CustomBorderRadius.medium),
            ),
            primary: color,
          ),
          child: (gradient != null)
              ? Ink(
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius:
                        BorderRadius.circular(CustomBorderRadius.medium),
                  ),
                  child: contents,
                )
              : contents,
          onPressed: onPressed,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    double leftPadding;
    double rightPadding;

    if (icon != null) {
      if (text != null) {
        leftPadding = 8.0;
        rightPadding = 12.0;
      } else {
        leftPadding = 0.0;
        rightPadding = 0.0;
      }
    } else {
      leftPadding = 12.0;
      rightPadding = 12.0;
    }

    final contents = Container(
      alignment: Alignment.center,
      height: height,
      child: showProgressIndicator
          ? CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(theme.colorScheme.onPrimary),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: leftPadding),
                if (icon != null) icon!,
                if (child != null) child!,
                if (text != null)
                  Expanded(
                    flex: wrapText ? 1 : 0,
                    child: Text(
                      text ?? '',
                      textAlign: TextAlign.center,
                      style: type == CustomButtonType.outlined
                          ? TextStyle(
                              fontSize: theme.textTheme.button!.fontSize,
                              color: color == null
                                  ? theme.colorScheme.error
                                  : color!)
                          : TextStyle(
                              fontSize: theme.textTheme.button!.fontSize),
                    ),
                  ),
                SizedBox(width: rightPadding),
              ],
            ),
    );

    return _buildCustomButtonType(contents, type, theme);
  }
}

enum CustomButtonType { standard, outlined }
