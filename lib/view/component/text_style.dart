
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle (BuildContext context,{double? size , double? spacing , FontWeight? fontWeight , Color? color,double? letterSpaceing,TextDecoration? textDecoration}){
  return GoogleFonts.cairo(
      fontSize: size,
      letterSpacing:spacing,
      fontWeight: fontWeight,
      color: color,
      decoration: textDecoration

  );
}