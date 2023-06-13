import 'dart:convert';

import 'package:doctorapp/Profile/profile_screen.dart';
import 'package:doctorapp/Screen/Histroy.dart';
import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:doctorapp/Screen/WishlistScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthenticationView/LoginScreen.dart';
import '../Booking/booking_screen.dart';
import '../Brand/enquiry_List_Screen.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/getUserProfileModel.dart';
import '../Notification/notification.dart';
import '../Profile/Update_password.dart';
import '../Static/privacy_Policy.dart';
import '../Static/terms_condition.dart';
import '../SubscriptionPlan/SubscriptionPlanList.dart';
import '../SubscriptionPlan/subscription_plan.dart';
import '../api/api_services.dart';
import 'package:http/http.dart'as http;

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int currentindex = 0;
  List<Widget> pages1 = <Widget>[
    HomeScreen(),
    ProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      currentindex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserProfile();
  }
  GetUserProfileModel? getprofile;
  getuserProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getProfile--------------->${userId}");
    var headers = {
      'Cookie': 'ci_session=d9075fff59f39b7a82c03ca267be8899c1a9fbf8'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll({'id': '$userId'});
    print("getProfile--------------->${request.fields}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
      GetUserProfileModel.fromJson(json.decode(finalResult));
      print("this is a ========>profile${jsonResponse}");
      print("emailllllll${getprofile?.data?.first.mobile}");
      setState(() {
        getprofile = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors.secondary),
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors.secondary),
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });

        return true;
      },
      child: SafeArea(
        child: Scaffold(
         drawer: getDrawer(),
          appBar: AppBar(

            centerTitle: true,
            iconTheme: IconThemeData(color:colors.blackTemp),
            backgroundColor:colors.whiteTemp,
            title: Image.asset("assets/splash/home.png",height: 100,width: 100,),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationList()));
                  },
                    child: Icon(Icons.notifications_active,color: colors.blackTemp,)),
              )
            ],
          ),
          body: Center(
            child: pages1.elementAt(currentindex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: colors.primary,
            //  elevation: 1,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'Profile', icon: Icon(Icons.people_alt_sharp)),
            ],
            currentIndex: currentindex,
            selectedItemColor: colors.whiteTemp,
            unselectedItemColor: colors.whiteTemp.withOpacity(0.6),
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedFontSize: 13,
            selectedFontSize: 13,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
  getDrawer() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 1.3,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [colors.primary, colors.secondary],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // main
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    "${getprofile?.data?.first.profilePic}",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${getprofile?.data?.first.username}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          "${getprofile?.data?.first.email}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft,
          //       colors: [
          //         colors.white10,
          //         colors.primary,
          //       ],
          //     ),
          //   ),
          //   child: ListTile(
          //     leading: Container(
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(50)),
          //       child: Image.asset(
          //         "assets/images/drawer1.png",
          //         color: colors.black54,
          //         scale: 1.3,
          //         height: 40,
          //         width: 40,
          //       ),
          //     ),
          //     title: Text(
          //       ' My Profile',
          //     ),
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (Context) => ProfileScreen()));
          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(builder: (context) => HomeScreen()),
          //       // );
          //     },
          //   ),
          // ),
          ListTile(
            leading: Image.asset(
              "assets/images/home.png",
              color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'Home',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomScreen()),
              );
            },
          ),

          ListTile(
            leading: Image.asset(
              "assets/images/Term & Conditions.png",
              color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'Inquiry List',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>SubmitEnquiryListScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/sub.png",
              color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'My Subscription Plan',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubscriptionPlanScreen()),
              );
            },
          ),

          ListTile(
            leading: Image.asset(
              "assets/images/Term & Conditions.png",
              height: 40,
              width: 40,
              color: colors.black54,
            ),
            title: Text(
              'Terms &Conditions',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsCondition()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/Privacy Policy.png",
              color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'Privacy Policy',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              );
            },
          ),



          // ListTile(
          //   leading: Image.asset(
          //     "assets/images/Change Password.png",
          //     color: colors.black54,
          //     height: 40,
          //     width: 40,
          //   ),
          //   title: Text(
          //     'Change Password',
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => UpdatePassword()),
          //     );
          //   },
          // ),
          ListTile(
            leading: Image.asset(
              "assets/images/Sign Out.png",
              color: colors.black54,
              height: 40,
              width: 40,
              //color: Colors.grey.withOpacity(0.8),
            ),
            title: Text(
              'Sign Out',
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirm Sign out"),
                      content: Text("Are  sure to sign out from app now?"),
                      actions: <Widget>[
                        ElevatedButton(
                          style:
                          ElevatedButton.styleFrom(primary: colors.primary),
                          child: Text("YES"),
                          onPressed: () async {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            setState(() {
                              prefs.clear();
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                        ),
                        ElevatedButton(
                          style:
                          ElevatedButton.styleFrom(primary: colors.primary),
                          child: Text("NO"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
