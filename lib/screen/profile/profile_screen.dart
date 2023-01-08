import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:renteadmin/screen/profile/profile_view.dart';
import '../../components/app_side_menu.dart';

class ProfileScreen  extends StatefulWidget {
  String? user_id,user_name,user_email,user_phone,user_profile;
  bool ? isDocumentVerified;
  String? frontImage="";
  String? backImage="";
  String? passportImage="";
  String? document_type="";
  ProfileScreen({this.user_id,this.user_name,this.user_email,this.user_phone,this.user_profile,this.isDocumentVerified,this.frontImage,this.backImage,this.passportImage});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen >{
  var isLoading = false;

  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return AppSideMenu( pageTitle: "View User",
      body:  SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: HexColor("#EFF1F5"),
            child: Column(
              children: [
                ProfileView(widget.user_id,widget.user_name,widget.user_email,widget.user_phone,widget.user_profile,widget.backImage,widget.frontImage,widget.document_type,widget.isDocumentVerified,widget.passportImage)

              ],
            ),
          )
      ),
    );
  }


}
