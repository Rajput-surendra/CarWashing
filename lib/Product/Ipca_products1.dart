
 import 'dart:convert';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/pharma_products_response.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Appbar.dart';
import 'package:http/http.dart'as http;

import 'Ipca_products2.dart';


 class  PharmaProductsDataScreen extends StatefulWidget {
 const  PharmaProductsDataScreen({Key? key, this.pharmaCategory,this.ProdectName,this.SliderId}) : super(key: key);
final  String? pharmaCategory ,ProdectName ,SliderId;

  @override
  State<PharmaProductsDataScreen> createState() => _PharmaProductsDataScreenState();
}

 class _PharmaProductsDataScreenState extends State<PharmaProductsDataScreen> {

  GetPharmaProducts? pharmaProducts ;

  List <PharmaProducts> pharmaProductsList = [] ;
  bool isLoading =  false ;

  @override
  void initState() {
    // TODO: implement initState
    getPharmaProducts();
    super.initState();

  }

  getPharmaProducts() async {
    isLoading = false ;
    setState(() {
    });
    String? userId;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? roll  =  preferences.getString('roll');
    if(roll == '1')
    {
     userId  =  preferences.getString('userId');
    }
    var headers = {
      'Cookie': 'ci_session=2c9c44fe592a74acad0121151a1d8648d7a78062'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getPharmaProducts}'));

    request.headers.addAll(headers);
    request.fields.addAll({
      'category_id': widget.pharmaCategory.toString(),
    });
    print("fieldss===========>11111111111111111${request.url}");
    print("fieldss===========>11111111111111111${request.fields}");
    http.StreamedResponse response = await request.send();
    print("response.statusCode===========>${response.statusCode}");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========>${result}");
      final finalResult = GetPharmaProducts.fromJson(json.decode(result));
      setState(() {
        pharmaProductsList = finalResult.data ?? [];

        isLoading = false ;

      });
    } else {
      isLoading = false ;
      setState(() {

      });
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context)  {
    print('__________${pharmaProducts?.data?.length}_____________');
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context: context, text:"Pharma Products", isTrue: true, ),
        body: SingleChildScrollView(
          child: Column(


            children:<Widget>[
              const SizedBox(height: 10,),
              // InkWell(
              //   onTap: () {
              //     //Navigator.push(context,MaterialPageRoute(builder: (context)=>const IpcaProductScreen2()));
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       height:MediaQuery.of(context).size.height/13,
              //       width:MediaQuery.of(context).size.width/1.09,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: colors.grad1Color),borderRadius: BorderRadius.circular(11),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: CircleAvatar(
              //               radius: 27,
              //               backgroundColor:colors.purpleColor,child: Text('Rheumatology'.substring(0,1),style:
              //             const TextStyle(fontSize: 20,color:colors.lightWhite2),),),
              //           ),
              //           const SizedBox(width: 20,),
              //           const Text('Rheumatology',style: TextStyle(fontWeight: FontWeight.w700),)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10,),
              isLoading ? const Center(child: CircularProgressIndicator(),) : pharmaProductsList.isEmpty ? Center(child: Text('No Data Found !!'),) :
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pharmaProductsList.length ?? 2,
                itemBuilder: (context, index) {
                 var item =  pharmaProductsList[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>IpcaProductScreen2(PharmaProduct:pharmaProductsList[index].id)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(maxRadius:27,child: Text('${item.name?.substring(0,1)}',style:
                          const TextStyle(fontSize: 20,color:colors.lightWhite2),),),
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text('${item.name}',style: const TextStyle(fontWeight: FontWeight.w700),),
                          ),
                          Container(
                              width: 250,
                              child: Text('${item.shortDescription}',maxLines: 4,overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.grey),))

                        ],)                  ],
                    ),
                  ),
                ) ;
              },)

            ],
          ),
        ),

      ),
    );
  }


}
