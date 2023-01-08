
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../components/app_side_menu.dart';
import '../../components/header.dart';
import '../../model/onBoarding_response.dart';
import '../../model/success_response.dart';
import '../../route/route_name.dart';
import '../../untils/responsive.dart';
import '../../untils/string_utils.dart';
import '../../widget/all_widgets.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'onboard_presenter.dart';
class AddOnBoardingScreen extends StatefulWidget {
  final String onBoardingName;
  final String onBoardingDescri;
  final String onBoardingId;
  final String imageUrl;
  AddOnBoardingScreen(
      {Key? key,
        required this.onBoardingName,
        required this.onBoardingDescri,
        required this.onBoardingId,
        required this.imageUrl,
      })
      : super(key: key);
  @override
  _AddOnBoardingScreenState createState() => _AddOnBoardingScreenState();
}

class _AddOnBoardingScreenState extends State<AddOnBoardingScreen> implements OnboardInterface{
  var isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  late OnboardPresenter onboardPresenter;
  @override
  void initState() {
    super.initState();
    onboardPresenter = OnboardPresenter(this);
    setState(() {
     nameController.text=widget.onBoardingName;
     desController.text=widget.onBoardingDescri;
    });
  }
  List<int>? _selectedFile;
  Uint8List? _bytesData;
  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result!);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
      print("Pick ::: "+_selectedFile.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppSideMenu(
        pageTitle: "Add Category",
        body: Container(
          color: HexColor("#EFF1F5"),
          child: Stack(
            children: [
              Column(
                children: [
                  Header(title: "OnBoarding View",type:1),
                  SizedBox(height: 22,),
                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    width:  Responsive().getResponsiveValue(
                        forLargeScreen: MediaQuery.of(context).size.width,
                        context: context),
                    child:  Card(
                        color: HexColor("#FFFFFF"),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Container(
                          width:  Responsive().getResponsiveValue(
                              forLargeScreen: MediaQuery.of(context).size.width,
                              context: context),
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      startWebFilePicker();
                        },

                                    child: Container(
                                      height: Responsive().getResponsiveValue(
                                          forLargeScreen:  MediaQuery.of(context).size.height/3.2,
                                          forShortScreen:MediaQuery.of(context).size.height/4,
                                          forTabletScreen:MediaQuery.of(context).size.height/4,
                                          context: context),
                                      width: Responsive().getResponsiveValue(
                                          forLargeScreen: MediaQuery.of(context).size.width/8,
                                          forShortScreen:MediaQuery.of(context).size.width/3,
                                          forTabletScreen:MediaQuery.of(context).size.width/3,
                                          context: context),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey
                                        ),
                                    image:_selectedFile!=null?
                                        DecorationImage(
                                          image:MemoryImage(_bytesData!),
                                          fit: BoxFit.fill
                                        ):
                                    widget.imageUrl!=""?
                                    DecorationImage(
                                        image:NetworkImage(widget.imageUrl),
                                        fit: BoxFit.fill
                                    ):
                                    const DecorationImage(
                                        image:AssetImage("assets/images/ic_screenshot.png"),

                                    )
                                      ),
                                    ),
                                    ),
                                  Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: const Text(
                                        "Add Your Photo",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 10.0,
                                        ),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Container(
                                    width: Responsive().getResponsiveValue(
                                        forLargeScreen: MediaQuery.of(context).size.width/2,
                                        forShortScreen:MediaQuery.of(context).size.width/3.2,
                                        forTabletScreen:MediaQuery.of(context).size.width/3.2,
                                        context: context),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 8.0,
                                        child: TextFormField(
                                          controller: nameController,
                                          cursorColor: Colors.black,
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                              hintText: "Name"),
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: Responsive().getResponsiveValue(
                                        forLargeScreen: MediaQuery.of(context).size.width/2,
                                        forShortScreen:MediaQuery.of(context).size.width/3.2,
                                        forTabletScreen:MediaQuery.of(context).size.width/3.2,
                                        context: context),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        elevation: 8.0,
                                        child: TextFormField(
                                          controller: desController,
                                          cursorColor: Colors.black,
                                          minLines: 8, // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                              hintText: "Description"),
                                        )
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (nameController.text.isEmpty) {
                                        AllWidgets.customDialog(UtilStrings.entername);
                                      }
                                      else if(_selectedFile==null && widget.imageUrl==""){
                                        AllWidgets.customDialog(UtilStrings.selectImage);
                                      }
                                      else if(widget.onBoardingName!="") {
                                        setState((){
                                          isLoading=true;
                                        });
                                        if(_selectedFile==null) {

                                          final http.Response responseData = await http.get(Uri.parse(widget.imageUrl)  ,
                                             );
                                          _selectedFile = responseData.bodyBytes;
                                        }
                                      onboardPresenter.doEditCategory(widget.onBoardingId,nameController.text.toString(),_selectedFile!,desController.text.toString());
                                      }
                                      else{
                                      }
                                    },
                                    child: Container(
                                      width: 120,
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.only(top: 30.0,bottom: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: HexColor("#F19900"),
                                      ),
                                      child: Text("Submit",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
              AllWidgets.progressDialogs(context, isLoading),
            ],
          ),
        )
    );
  }


  @override
  onAddCategorySuccess(SuccessResponse user) {
    setState(() {
      isLoading=false;
    });
    if(user.status==200){
      AllWidgets.customDialog(user.message!);
      Navigator.pushNamed(context, RouteNames.onBoardingListScreen);
    }
    else{
      AllWidgets.customDialog(user.message!);
    }
  }

  @override
  onError(String msg) {
    setState(() {
      isLoading=false;
    });

  }

  @override
  onOnboardSuccess(OnboardingResponse user) {

  }





}


