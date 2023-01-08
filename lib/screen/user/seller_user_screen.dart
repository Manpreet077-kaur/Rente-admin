import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:renteadmin/screen/user/user_presenter.dart';
import 'package:renteadmin/untils/responsive_web_app.dart';
import '../../components/app_side_menu.dart';
import '../../components/header.dart';
import '../../model/success_response.dart';
import '../../model/user_response.dart';
import '../../untils/color_utils.dart';
import '../../untils/constants.dart';
import '../../untils/responsive.dart';
import '../../widget/all_widgets.dart';
import '../profile/profile_screen.dart';

class SellerUserScreen extends StatefulWidget {
  @override
  _SellerUserScreenState createState() => _SellerUserScreenState();
}

class _SellerUserScreenState extends State<SellerUserScreen> implements ViewUserInterface{
  var isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  late ViewUserPresenter viewUserPresenter;
  List<UserData> userDataList=[];
  List <UserData> _searchList = [] ;
  bool status=true;
  var message="";
  int skip=0;
  int _currentPage=1;
  int limit=6;
  double _totalpage=0;
  @override
  void initState() {
    super.initState();
    viewUserPresenter = ViewUserPresenter(this);
    setState(() {
      isLoading=true;
      viewUserPresenter.doUserListAPI("1",1);
    });
  }
  void _searchingData(String enteredKeyword) {
    userDataList.clear();
    if (enteredKeyword.isEmpty) {
     // viewUserPresenter.doUserListAPI();
    } else {
      //viewUserPresenter.doUserListAPI();
    }
  }
  int _counter = 1;
  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return AppSideMenu(
      pageTitle: "Users",
      body:  Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: HexColor("#EFF1F5"),
              child: Column(
                children: [
                  const Header(title: "Seller Users",type:1),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width:displayMobileLayout? MediaQuery.of(context).size.width:
                          MediaQuery.of(context).size.width/4,
                          child: Card(
                              margin: const EdgeInsets.only(top: 10,left:20,right: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 8.0,
                              child: TextFormField(
                                cursorColor: Colors.black,
                                onChanged: (value) => _searchingData(value),
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search,size: 24,color: Colors.black,),
                                  hintText: "Search",
                                  hintStyle:TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal),
                                ),
                              )
                          )),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      userDataList.isNotEmpty?Expanded(
                        flex:userDataList.length,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height/1.5,
                              margin: const EdgeInsets.all(22),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  color: Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height/1.5,
                                    child: DataTable2(
                                      columnSpacing: Constants.defaultPadding,
                                      minWidth: 600,
                                      columns: const [
                                        DataColumn(
                                          label: Text("Name"),
                                        ),
                                        DataColumn(
                                          label: Text("Email"),
                                        ),
                                        DataColumn(
                                          label: Text("Phone Number"),
                                        ),
                                        DataColumn(
                                          label: Text("Registered"),
                                        ),
                                        DataColumn(
                                          label: Text("Status"),
                                        ),
                                        DataColumn(
                                          label: Text("Action"),
                                        ),
                                      ],
                                      rows: List.generate(
                                        userDataList.length,
                                            (index) => recentFileDataRow(userDataList[index],context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (ResponsiveWebApp.isMobile(context))
                               SizedBox(height: Constants.defaultPadding),
                          ],
                        ),
                      ):Center(child: Container()),
                      if (!ResponsiveWebApp.isMobile(context))
                         SizedBox(width: Constants.defaultPadding),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AllWidgets.progressDialogs(context, isLoading),
          //AllWidgets.noRecord(context, userInfoData.length)
        ],
      ),
    );
  }

  @override
  onError(int errorCode) {
    setState(() {
      isLoading=false;
    });
  }

  DataRow recentFileDataRow(UserData userInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 10, // Image radius
                backgroundImage: NetworkImage(Constants.BASE_URL_IMAGE+userInfo.profilePicture.toString(),)),
              // Image.asset("assets/images/profile_pic.png",height: 20, width: 20),
              SizedBox(width:4),
              Text(userInfo.name.toString(),style: TextStyle(fontSize: 12),),
            ],
          ),
        ),

        DataCell(Text(userInfo.email!,style: TextStyle(fontSize: 12),)),
        DataCell(Text(userInfo.phoneNumber.toString(),style: TextStyle(fontSize: 12),)),

        DataCell(Text(Constants.dateConvertor(userInfo.createdAt.toString()),style: TextStyle(fontSize: 12),)),
        DataCell(GestureDetector(
          onTap: (){
            showAlertblockDialog(context,userInfo.sId.toString(), userInfo.blockedByAdmin);
          },
          child: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: userInfo.blockedByAdmin==false ?HexColor("#3FB85C"):AppColor.btn_red
            ),
            child:Text(userInfo.blockedByAdmin==false?"Activate":"Deactivate",style: TextStyle(color: Colors.white,fontSize: 12),) ,
          ),
        ),),
        DataCell(GestureDetector(
          onTap: (){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    user_id: userInfo.sId.toString(),
                    user_name: userInfo.name.toString(),
                    user_email: userInfo.email.toString(),
                    user_phone: userInfo.phoneNumber.toString(),
                    user_profile: userInfo.profilePicture.toString(),
                    isDocumentVerified: userInfo.isDocumentVerified,
                    frontImage: userInfo.idCardImage!.isNotEmpty?Constants.BASE_URL_IMAGE+userInfo.idCardImage![0]:"https://d1qnfbq5bku950.cloudfront.net/1659702644436-no_image_available.png",
                    backImage: userInfo.idCardImage!.isNotEmpty?Constants.BASE_URL_IMAGE+userInfo.idCardImage![1]:"https://d1qnfbq5bku950.cloudfront.net/1659702644436-no_image_available.png",
                    passportImage:  userInfo.passportImage!.isNotEmpty?Constants.BASE_URL_IMAGE+userInfo.passportImage![0]:"https://d1qnfbq5bku950.cloudfront.net/1659702644436-no_image_available.png",
                  ),
                ));
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.lightBlue
            ),
            child:const Text("Show",style: TextStyle(color: Colors.white,fontSize: 12),) ,
          ),
        ),),
      ],
    );
  }

  showAlertblockDialog(BuildContext context, String user_id, bool? isUserVerifiedByAdmin) {
    if(isUserVerifiedByAdmin==false){
      message="Are you sure want to Deactivate this User?";
      status=true;
    }
    else{
      message="Are you sure want to activate this User?";
      status=false;
    }
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
                      child: Image.asset("assets/images/logo.png",height: 30,color: Colors.black,
                        width: MediaQuery.of(context).size.width/2.5,),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                   Center(
                    child:
                    Text(message,style: const TextStyle(color:Colors.black,fontWeight: FontWeight.w600),),
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
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:Container(
                                width: 120,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.only(top: 30.0,bottom: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: HexColor("#112153"))
                                ),
                                child: Text("No",textAlign:TextAlign.center,style: TextStyle(color: HexColor("#112153")),),
                              )),
                          SizedBox(width: 12,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isLoading=true;
                              });
                              viewUserPresenter.doUserBlockAPI(user_id, isUserVerifiedByAdmin==false?"1":"0");
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.only(top: 30.0,bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor("#65A2A2"),
                              ),
                              child: const Text("Yes",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
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
  onUserSuccess(UserResponse user) {
    print("User Response::-"+user.data.toString());
    userDataList.clear();
    setState(() {
      isLoading=false;
    });
    if(user.status==200){
      setState(() {
        isLoading=false;
        userDataList.addAll(user.data!);
        _totalpage=user.data!.length!/6;
      });
    }
    else{
    }
  }
  @override
  onBlockUserSuccess(SuccessResponse user) {
    setState(() {
      isLoading=false;
    });
    AllWidgets.customDialog(user.message!);
    userDataList.clear();
    setState(() {
      isLoading=true;
      viewUserPresenter.doUserListAPI("1",1);
    });
  }

  @override
  onVerifyUnverifySuccess(SuccessResponse user) {
  }
}
