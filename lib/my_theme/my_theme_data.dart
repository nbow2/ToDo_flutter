import 'package:flutter/material.dart';
import 'package:todo_demo/my_theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {

  static final ThemeData light = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.white
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.black
      ),
      bodyLarge:GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.black
      ),
        bodyMedium:GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.black
        ),
      labelLarge: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.black
      ),
      labelMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.gray,
      showSelectedLabels: false,
      backgroundColor:Colors.transparent,
      elevation: 0
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: BorderSide(
          color: AppColors.white,
          width: 4
        )
      ),
      foregroundColor: AppColors.white
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(15) , topRight: Radius.circular(15)),
        side: BorderSide(),
      )
    )

  ) ;
  static final ThemeData dark = ThemeData() ;

}