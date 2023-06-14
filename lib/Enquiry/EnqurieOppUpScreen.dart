import 'package:doctorapp/Screen/Bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Helper/Color.dart';

class EnqurieDetails extends StatefulWidget {
  const EnqurieDetails({Key? key}) : super(key: key);

  @override
  State<EnqurieDetails> createState() => _EnqurieDetailsState();
}

class _EnqurieDetailsState extends State<EnqurieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.darkIcon,
      // bottomSheet: Container(
      //   color: colors.darkIcon,
      //   child: InkWell(
      //     onTap: (){
      //
      //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomScreen()));
      //
      //       Fluttertoast.showToast(
      //           msg: "Enquire Generate Successfully",
      //           toastLength: Toast.LENGTH_SHORT,
      //           gravity: ToastGravity.BOTTOM,
      //           timeInSecForIosWeb: 5,
      //           backgroundColor: colors.primary,
      //           textColor: Colors.white,
      //           fontSize: 16.0
      //       );
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         height: 40,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: colors.primary
      //         ),
      //         child: Center(child: Text("Enquire Genrate",style: TextStyle(color: colors.whiteTemp),)),
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/enquri.png"),
            SizedBox(height: 30,),
            Container(
              color: colors.darkIcon,
              width: MediaQuery.of(context).size.width/1.5,
              child: InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomScreen()));
                  // Fluttertoast.showToast(
                  //     msg: "Enquire Generate Successfully",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.BOTTOM,
                  //     timeInSecForIosWeb: 5,
                  //     backgroundColor: colors.primary,
                  //     textColor: Colors.white,
                  //     fontSize: 16.0
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.primary
                    ),
                    child: Center(child: Text("Continue Booking",style: TextStyle(color: colors.whiteTemp),)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
