import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy/shared/styles/colors.dart';

var darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: HexColor('#18191a'),

    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(HexColor('#e4e6eb'))
      )
    ),
    cardTheme: CardTheme(
      color: HexColor('#242526'),
      
    ),
   
    tabBarTheme: TabBarTheme(
      labelColor: const Color.fromARGB(255, 129, 85, 249),
      unselectedLabelColor: HexColor('#e4e6eb'),
      dividerColor:  HexColor('#b0b3b8')
      
    ),
    appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: HexColor('#e4e6eb')
    ),
        actionsIconTheme:  IconThemeData(color:  HexColor('#e4e6eb')),
        titleTextStyle: GoogleFonts.merriweather(
        fontSize: 25,
         color: Colors.white, fontWeight: FontWeight.w500),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            
            statusBarColor: HexColor('#18191a')),
        backgroundColor: HexColor('#18191a'),
        elevation: 0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor('#262626'),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey),
     textTheme:  TextTheme(
    headlineMedium: TextStyle(
          //fontSize: 30,
           fontWeight: FontWeight.w900, 
           color: Colors.purple[400]),

           bodySmall: GoogleFonts.gulzar(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: HexColor('b0b3b8')
           ),
           
           titleMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w400, height: 1.23,
            color: Colors.white
           ),
           labelLarge: GoogleFonts.gulzar(
            
           ),
      bodyMedium:  GoogleFonts.gulzar(
          fontSize: 20,
           fontWeight: FontWeight.w500, 
           color: Colors.white)),

            );
//////////////////////////

var lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  // applyElevationOverlayColor: false,
  textTheme:  TextTheme(
    headlineMedium: TextStyle(
          //fontSize: 30,
           fontWeight: FontWeight.w900, 
           color: defaultColor),

           bodySmall: GoogleFonts.gulzar(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700]
           ),
           labelLarge: GoogleFonts.gulzar(
            
           ),
      bodyMedium:  GoogleFonts.gulzar(
          fontSize: 20,
           fontWeight: FontWeight.w500, 
           color: Colors.black)),
  appBarTheme: AppBarTheme(
    actionsIconTheme: const IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.grey[200]),
    titleTextStyle: GoogleFonts.merriweather(
        fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500),
    backgroundColor: Colors.white,
    elevation: 0,

    //systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.grey[200])
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[200],
      
      elevation: 0,
      type: BottomNavigationBarType.fixed),

  primarySwatch: defaultColor,
  // useMaterial3: true,
);
