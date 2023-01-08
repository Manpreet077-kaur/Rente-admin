import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:renteadmin/model/success_response.dart';
import 'package:renteadmin/model/user_response.dart';
import 'package:renteadmin/untils/constants.dart';
import '../../components/header.dart';
import '../../components/snackbar.dart';
import '../../untils/responsive.dart';
import '../../widget/all_widgets.dart';
import '../../widget/full_image_view.dart';
import '../user/user_presenter.dart';

class ProfileView extends StatefulWidget {
  String? backImage;
  String? frontImage,passportImage;
  String? document_type;
  String? user_id,user_name,user_email,user_phone,user_profile;
  bool? isDocumentVerified;
  ProfileView(this.user_id,this.user_name,this.user_email,this.user_phone,this.user_profile,this.backImage,this.frontImage,this.document_type,this.isDocumentVerified,this.passportImage, {
    Key? key,
  }) : super(key: key);


  @override
  _ProfileViewState createState() => _ProfileViewState();
}
class _ProfileViewState extends State<ProfileView> implements ViewUserInterface{
  var isLoading = false;
  late ViewUserPresenter viewUserPresenter;

  @override
  void initState() {
    super.initState();
    viewUserPresenter = ViewUserPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Column(children: [
         const Header(title: "Users Details",type:0),
          SizedBox(height: 22,),
         Stack(children: [
           Container(
             margin: EdgeInsets.only(left: 20,right: 20),
             width:  Responsive().getResponsiveValue(
                 forLargeScreen: MediaQuery.of(context).size.width,
                 context: context),
             child: Card(
                 color: HexColor("#FFFFFF"),
                 elevation: 8.0,
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(4)
                 ),
                 child: Container(
                   padding: EdgeInsets.all(22),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Container(
                                   height: 42,
                                   width: 42,
                                   child:  widget.user_profile==""?
                                   Image.asset('assets/images/no_image_available.png', height:22, width: 22, fit: BoxFit.fill,)
                                       :
                                   CircleAvatar(
                                       radius: 10, // Image radius
                                       backgroundImage: NetworkImage(Constants.BASE_URL_IMAGE+widget.user_profile.toString(),))),
                               const SizedBox(width: 10,),
                               Text(widget.user_name.toString()),
                             ],
                           ),
                           const SizedBox(height: 18,),
                           Container(
                             width: MediaQuery.of(context).size.width/1.5,
                             height: 1,
                             color: Colors.black12,
                           ),
                           const SizedBox(height: 38,),
                           Row(
                             children: [
                               Row(
                                 children: [
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: const [
                                       Text("Name"),
                                       SizedBox(height: 14,),
                                       Text("Email"),
                                       SizedBox(height: 14,),
                                       Text("Phone"),
                                       SizedBox(height: 14,),
                                     ],
                                   ),
                                   !displayMobileLayout? const SizedBox(
                                     width: 80,
                                   ):const SizedBox(
                                     width: 10,
                                   ),
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(widget.user_name.toString()),
                                       const SizedBox(height: 14,),
                                       Text(widget.user_email.toString()),
                                       const SizedBox(height: 14,),
                                       Text(widget.user_phone.toString()),
                                       const SizedBox(height: 14,),
                                     ],
                                   ),
                                 ],
                               ),
                               !displayMobileLayout? const SizedBox(
                                 width: 50,
                               ):const SizedBox(
                                 width: 10,
                               ),
                             ],
                           ),
                           const SizedBox(height: 34,),
                           Container(
                             width: MediaQuery.of(context).size.width/1.5,
                             height: 1,
                             color: Colors.black12,
                           ),
                           const SizedBox(height: 34,),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const Text("ID Card",style: TextStyle(fontSize: 26),),
                                   SizedBox(height:8),
                                   Row(
                                     children: [
                                       GestureDetector(
                                         onTap: (){
                                           Navigator.push(context,
                                               MaterialPageRoute(builder: (_) {
                                                 return FullScreenImage(
                                                   imageUrl:widget.frontImage.toString(),
                                                   tag: "front_image",
                                                 );
                                               }));
                                         },
                                         child: SizedBox(
                                           height: 140,width: 160,
                                           child: Hero(
                                             tag: "front_image",
                                             child: Image.network(widget.frontImage.toString(),height: 140,width: 160,fit: BoxFit.fill,
                                               errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                 return Image.asset("assets/images/no_image_available.png",height: 140,width: 160,);
                                               },),
                                           ),
                                         ),
                                       ),
                                       !displayMobileLayout? const SizedBox(
                                         width: 10,
                                       ):const SizedBox(
                                         width: 10,
                                       ),
                                       GestureDetector(
                                         onTap: (){
                                           Navigator.push(context,
                                               MaterialPageRoute(builder: (_) {
                                                 return FullScreenImage(
                                                   imageUrl:widget.backImage!,
                                                   tag: "back_image",
                                                 );
                                               }));
                                         },
                                         child: SizedBox(
                                           height: 140,width: 160,
                                           child: Hero(
                                             tag: "back_image",
                                             child: Image.network(widget.backImage!.toString(),height: 140,width: 160,fit: BoxFit.fill,errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                               return Image.asset("assets/images/no_image_available.png",height: 140,width: 160,);
                                             },),
                                           ),
                                         ),
                                       )
                                     ],
                                   ),
                                 ],),

                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const Text("       Passport",style: TextStyle(fontSize: 26),),
                                   SizedBox(height:8),
                                   Row(
                                     children: [
                                       GestureDetector(
                                         onTap: (){
                                           Navigator.push(context,
                                               MaterialPageRoute(builder: (_) {
                                                 return FullScreenImage(
                                                   imageUrl:widget.passportImage.toString(),
                                                   tag: "passport_image",
                                                 );
                                               }));
                                         },
                                         child: Container(
                                           margin: EdgeInsets.only(left: 40),
                                           child: SizedBox(
                                             height: 140,width: 160,
                                             child: Hero(
                                               tag: "passport_image",
                                               child: Image.network(widget.passportImage.toString(),height: 140,width: 160,fit: BoxFit.fill,
                                                 errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                   return Image.asset("assets/images/no_image_available.png",height: 140,width: 160,);
                                                 },),
                                             ),
                                           ),),
                                       ),
                                       !displayMobileLayout? const SizedBox(
                                         width: 10,
                                       ):const SizedBox(
                                         width: 10,
                                       ),
                                     ],
                                   ),
                                 ],)

                             ],),
                           Row(
                             children: [
                               widget.isDocumentVerified==false?Center(
                                 child: GestureDetector(
                                   onTap: (){
                                     showAlertblockDialog(context,widget.user_id.toString(),widget.isDocumentVerified!,"Verify",1);
                                   },
                                   child: Container(
                                     width: 80,
                                     padding: const EdgeInsets.all(10.0),
                                     margin: const EdgeInsets.only(top: 20.0),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(8),
                                       color: HexColor("#037EE6"),
                                     ),
                                     child: const Text("Verify",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                                   ),
                                 ),
                               ):Container(),
                               !displayMobileLayout? const SizedBox(
                                 width: 40,
                               ):const SizedBox(
                                 width: 10,
                               ),
                               widget.isDocumentVerified==true?Center(
                                 child: GestureDetector(
                                   onTap: (){
                                     showAlertblockDialog(context,widget.user_id.toString(),widget.isDocumentVerified!,"Unverify",0);
                                   },
                                   child: Container(
                                     width: 80,
                                     padding: const EdgeInsets.all(10.0),
                                     margin: const EdgeInsets.only(top: 20.0),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(8),
                                       color: HexColor("#FF6666"),
                                     ),
                                     child: const Text("Unverify",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                                   ),
                                 ),
                               ):Container(),
                             ],
                           ),
                         ],
                       ),
                       !displayMobileLayout? const SizedBox(
                         width: 50,
                       ):const SizedBox(
                         width: 10,
                       ),

                     ],
                   ),
                 )
             ),
           ),
           AllWidgets.progressDialogs(context, isLoading),
         ],),
        SizedBox(height: 22,),
        ],);
  }
  showAlertblockDialog(BuildContext context, String user_id, bool status,String message, int type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          actions: [
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              width:  Responsive().getResponsiveValue(
                  forLargeScreen: MediaQuery.of(context).size.width/4,
                  context: context),
              height:  Responsive().getResponsiveValue(
                  forLargeScreen: MediaQuery.of(context).size.height/3,
                  context: context),
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40,bottom: 10.0),
                    child: Center(
                      child: Image.asset("assets/images/logo.png",height: 60,color: Colors.black,
                        width: MediaQuery.of(context).size.width/2.5,),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  /* Center(
                    child:
                    Text("Log Out",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
                  ),*/
                   Center(
                    child:
                    Text("Are you sure want to "+message.toString()+" user?",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 30.0,bottom: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: HexColor("#112153"))
                            ),
                            child: Text("No",textAlign:TextAlign.center,style: TextStyle(color: HexColor("#112153")),),
                          ),
                          SizedBox(width: 12,),
                          GestureDetector(
                            onTap: (){
                              if(type==1){
                                setState(() {
                                  isLoading=true;
                                });
                                viewUserPresenter.doVerifyUnverifyAPI(user_id,"1");
                                Navigator.pop(context);
                              }
                              else {
                                setState(() {
                                  isLoading=true;
                                });
                                viewUserPresenter.doVerifyUnverifyAPI(user_id,"0");
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor("#65A2A2"),
                              ),
                              child: Text("Yes",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  onBlockUserSuccess(SuccessResponse user) {
  }

  @override
  onError(int errorCode) {
    setState(() {
      isLoading=false;
    });
  }

  @override
  onUserSuccess(UserResponse user) {
  }

  @override
  onVerifyUnverifySuccess(SuccessResponse user) {
    setState(() {
      isLoading=false;
      if(widget.isDocumentVerified==true){
        widget.isDocumentVerified=false;
      }
      else{
        widget.isDocumentVerified=true;
      }

    });
    AllWidgets.customDialog(user.message!);
  }


}
