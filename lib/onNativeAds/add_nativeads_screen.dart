

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:renteadmin/model/advertise_response.dart';
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

import 'nativeads_presenter.dart';
class AddNativeAdsScreen extends StatefulWidget {

  @override
  _AddNativeAdsScreenState createState() => _AddNativeAdsScreenState();
}

class _AddNativeAdsScreenState extends State<AddNativeAdsScreen> implements NativeAdsInterface{
  var isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  late NativeAdsPresenter nativeAdsPresenter;
  @override
  void initState() {
    super.initState();
    nativeAdsPresenter = NativeAdsPresenter(this);

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
      print("file::::"+file.toString());
      print("files::::"+files.toString());
      print("uploadInput::::"+uploadInput.toString());
      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result!);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(()  {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
      print("Pick ::: "+_selectedFile.toString());

    });
  }
  PlatformFile? objFile ;
  var fileBytes;
  String? filePath;
  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        //objFile = result.files.single;
        fileBytes = result.files.first.bytes;
        filePath = result.files.first.name;
        //filePath=objFile!.name.toString();
      });
    }
   print("fileBytes"+fileBytes);
  }

  @override
  Widget build(BuildContext context) {
    return AppSideMenu(
        pageTitle: "Add Native Ads",
        body: Container(
          color: HexColor("#EFF1F5"),
          child: Stack(
            children: [
              Column(
                children: [
                  Header(title: "Add Native Ads",type:1),
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
                                      //startWebFilePicker();
                                      chooseFileUsingFilePicker();
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
                                    image:fileBytes!=null?
                                        DecorationImage(
                                          image:MemoryImage(fileBytes),
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
                                          controller: urlController,
                                          cursorColor: Colors.black,
                                          minLines: 8, // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                              hintText: "Enter website URL"),
                                        )
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                     /* File decodedimgfile = await File("image.jpg").writeAsBytes(_bytesData!);
                                      print("decodedimgfile ::: "+decodedimgfile.toString());*/
                                      if (nameController.text.isEmpty) {
                                        AllWidgets.customDialog(UtilStrings.enterTitle);
                                      }
                                      else if(urlController==null){
                                        AllWidgets.customDialog(UtilStrings.url);
                                      }
                                      else if(fileBytes==null){
                                        AllWidgets.customDialog(UtilStrings.selectImage);
                                      }
                                      else {
                                        setState(() {
                                          isLoading=true;
                                        });

                                        nativeAdsPresenter.doAddNativeAds(
                                            nameController.text.toString(),
                                            fileBytes!,
                                            urlController.text.toString(),filePath.toString());
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
  onAddNativeAdsSuccess(SuccessResponse user) {
    setState(() {
      isLoading=false;
    });
    if(user.status==200){
      AllWidgets.customDialog(user.message!);
      Navigator.pushNamed(context, RouteNames.nativeAdsListScreen);
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
  onNativeAdsListSuccess(AdvertisementResponse user) {

  }

  @override
  onAdsDisableSuccess(SuccessResponse user) {

  }

  @override
  onEditAdsSuccess(SuccessResponse user) {

  }
}


