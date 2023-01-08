import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../untils/constants.dart';

class Header extends StatelessWidget {
  final String title;
  final int type;
  const Header({
    Key? key,
    required this.title,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 12,right: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(color:HexColor("#F19900")),
          ),
          Spacer(flex: 2),
          type!=0?Container(padding: EdgeInsets.all(26), ):ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Container(
      margin: EdgeInsets.only(left: Constants.defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: Constants.defaultPadding,
          vertical: Constants.defaultPadding * 0.5
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 28,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding * 0.5),
            child: Text("Rente",style: TextStyle(color: HexColor("#F19900"),)),
          ),
        ],
      ),
    );
  }
}

