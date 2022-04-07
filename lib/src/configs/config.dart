import 'dart:io';

import 'package:chaty/src/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class Config {
  Config._();
  static Config instance = Config._();

  // ? Data
  String appName = 'chaty';
  String baseUrl = "https://api.themoviedb.org/3/";
  String apiKey = "";
  String imageBaseUrl = "https://image.tmdb.org/t/p/";

  // *  Colors
  Color get primary => const Color(0xFF0073da);
  Color get boxColor => const Color(0xFFF0F0F0);
  Color get textColor => const Color(0xFF232323);
  Color get loaderGrey => const Color.fromRGBO(0, 0, 0, 0.07);
  Color get lightGrey => const Color(0xFFf0f0f0);
  Color get grey => const Color(0xFF808080);
  Color get black => const Color(0xFF232323);
  Color get white => const Color(0xFFFFFFFF);
  Color get blue => const Color(0xFF3498db);
  Color get green => const Color(0xFF4caf50);
  Color get placeholderTextColor => const Color(0xFF232323);
  Color get red => const Color(0xFFe52d27);
  Color get appBackgroundColor => const Color(0xfff0f0f0);
  Color get headingGrey => const Color(0xFF999999);
  Color get seperatorColorGrey => const Color(0xfff4f4f4);
  Color get googleRed => const Color(0xFFdd4b39);
  Color get facbookBlue => const Color(0xFF3B5998);

  // *  ThemeData
  ThemeData theme() => ThemeData(
      backgroundColor: const Color(0xFFF0F0F0),
      primaryColor: primary,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: primary,
        error: const Color(0xFFe52d27),
        secondary: primary,
        onSecondary: primary,
        surface: const Color(0xFFF0F0F0),
        onSurface: const Color(0xFFF0F0F0),
        background: const Color(0xFFF0F0F0),
        onBackground: const Color(0xFFF0F0F0),
        onError: const Color(0xFFe52d27),
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        headline2: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        headline3: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        headline4: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        headline5: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        headline6: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        subtitle1: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        subtitle2: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        bodyText1: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        bodyText2: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        button: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
        caption: GoogleFonts.poppins(
          fontSize: 8,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF232323),
        ),
      ));

  // * Assets Images

  // ! bottom bar icons

  //! languages flags

  // ? links

  // ? sizes

  double get radius => 15;
  double get topPadding => 50;

  //! Widgtes
  Widget loader() {
    return Platform.isIOS
        ? CupertinoActivityIndicator(
            color: primary,
          )
        : CircularProgressIndicator(
            color: primary,
            strokeWidth: 2,
          );
  }

  showErrorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.height * .4,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Ionicons.information_circle_outline,
                        color: Config.instance.primary,
                        size: 80,
                      ).paddingOnly(bottom: 20, top: 10),
                      Text(
                        "Error !",
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            color: Config.instance.black),
                      ).paddingOnly(bottom: 20),
                      Text(
                        message,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                            color: Config.instance.black),
                      ).paddingOnly(bottom: 20),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Config.instance.primary,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Config.instance.primary.withOpacity(.5),
                                  offset: const Offset(0, 10),
                                  blurRadius: 10,
                                ),
                              ]),
                          child: Center(
                            child: Text(
                              "OK",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Config.instance.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ).paddingOnly(bottom: 20, left: 10, right: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  loading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: loader(),
          );
        });
  }

  share(String text) {
    Share.share(text);
  }
}
