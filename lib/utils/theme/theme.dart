import 'package:flutter/material.dart';

class CustomColors {
  static const primary = Color(0xff40549e);
  static const primaryGradient = CustomColorGradient(
    Color(0xff6966fb),
    Color(0xff8b6cfb),
  );
  static const secondaryGradient = CustomColorGradient(
    const Color(0xffEB3567),
    const Color(0xffFAB364),
  );

  static const darkText = Color(0xff3a3b3d);
  static const lightText = Color(0xff888888);
  static const link = Color(0xff3399ff);
  static const imageBackground = Color(0xfff1f1f1);
  static const divider = Color(0xffe7e9eb);
  static const mainBackground = Colors.white;
  static const secondaryBackground = Color(0xfff5f5f5);
  static const leftMenu = primary;
  static const leftMenuText = Color(0xffffffff);
  static const leftMenuIcon = Color(0xffffffff);
  static const leftMenuSelected = Color.fromRGBO(0, 0, 0, 0.12);
  static const lightGreen = Color(0xff72BB53);
  static final disabled = primary;
  static const grayedout = Color(0x8Affffff);

  static const primaryColor = Color(0xFF8069fc);
  static const secondaryColor = Color(0xff6966fb);
  static const lightCyan = Color(0xFFB4E0FF);
  static const dividerColor = Color(0xFF707171);
  static const borderColor = Color(0xFF373737); //15%
  static const hintColor = Color(0xFF989898);
  static const customGreen = Color(0x8A4bde55);
  static const customRed = Color(0xffFABCBA);
}

class CustomFontSizes {
  static const xSmall = 10.0;
  static const small = 14.0;
  static const medium = 18.0;
  static const large = 24.0;
  static const xLarge = 34.0;
}

class CustomIconSizes {
  static const small = 26.0;
  static const medium = 30.0;
  static const large = 36.0;
}

class CustomSpacing {
  static const xSmall = 4.0;
  static const small = 8.0;
  static const medium = 16.0;
  static const large = 32.0;
  static const xLarge = 64.0;
}

class CustomBorderRadius {
  static const small = 5.0;
  static const medium = 10.0;
  static const large = 20.0;
}

class CustomBreakpoints {
  static const xLargeScreen = 1400.0;
  static const largeScreen = 900.0;
  static const mediumScreen = 600.0;
  static const smallScreen = 400.0;
}

class CustomConstraints {
  static const maxSectionWidth = 1000.0;
}

class CustomDividers {
  static Border get bottomBorder {
    return Border(bottom: BorderSide(color: CustomColors.divider, width: 1.0));
  }

  static Border get botAnTopBorder {
    return Border(
        bottom: BorderSide(color: CustomColors.divider, width: 1.0),
        top: BorderSide(color: CustomColors.divider, width: 1.0));
  }

  static Border get topBorder {
    return Border(top: BorderSide(color: CustomColors.divider, width: 1.0));
  }

  static Container get horizontalDivider {
    return Container(height: 1.0, color: CustomColors.divider);
  }

  static Container get verticalDivider {
    return Container(width: 1.0, color: CustomColors.divider);
  }
}

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Asap',
      primaryColor: CustomColors.primary,
      accentColor: CustomColors.primary,
      disabledColor: CustomColors.disabled,
      colorScheme: ColorScheme.light().copyWith(
          background: Colors.white,
          onBackground: CustomColors.darkText,
          primary: CustomColors.primary,
          onPrimary: Colors.white,
          secondary: CustomColors.primary,
          onSecondary: Colors.white),
      dividerColor: CustomColors.divider,
      textTheme: const TextTheme(
        headline5: const TextStyle(
          color: CustomColors.darkText,
          fontSize: CustomFontSizes.large,
          fontWeight: FontWeight.w500,
        ),
        bodyText2: const TextStyle(
          color: CustomColors.darkText,
          fontSize: CustomFontSizes.small,
        ),
        bodyText1: const TextStyle(
          color: CustomColors.darkText,
          fontSize: CustomFontSizes.small,
          fontWeight: FontWeight.bold,
        ),
        button: const TextStyle(
          fontSize: CustomFontSizes.small,
        ),
      ),
      iconTheme: IconThemeData(
        color: CustomColors.primary,
      ),
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        brightness: Brightness.light,
        elevation: 1,
        iconTheme: IconThemeData(color: CustomColors.darkText),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: CustomColors.darkText,
            fontSize: CustomFontSizes.medium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class CustomColorGradient {
  final Color color1;
  final Color color2;

  const CustomColorGradient(this.color1, this.color2);
}
