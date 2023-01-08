import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {

  static final primaryColor = Color(0xFF2697FF);
  static final secondaryColor = Color(0xFF2A2D3E);
  static final bgColor = Color(0xFF212332);
  static final BASE_URL_IMAGE = "https://d1qnfbq5bku950.cloudfront.net/";
  static final defaultPadding = 16.0;

  static String dateConvertor(String date) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime gettingDate = format.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(gettingDate);
    return formatted;
  }

}