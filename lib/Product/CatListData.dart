import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/Get_company_model.dart';
import '../New_model/pharma_products_category_response.dart';
import '../api/api_services.dart';
import 'Ipca_products1.dart';
import 'package:http/http.dart'as http;

class CatListData extends StatefulWidget {
  const CatListData({Key? key,this.companyid, this.companyName}) : super(key: key);
  final  String? companyid , companyName;


  @override
  State<CatListData> createState() => _CatListDataState();
}

class _CatListDataState extends State<CatListData> {
  bool isLodding =  false;

  List <PharmaProductCategoryDataList> pharmaProductList = [];
  List <PharmaProductCategoryDataList> pharmaProductListOld = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsCategory();

  }
  String? roll;
  getProductroll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    roll = preferences.getString('roll');
    print("this is reeeeeeeeererererer==============>${roll}");
  }
  GetPharmaProductsCategory? getPharmaProductsCategory;
  getProductsCategory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    roll = preferences.getString('roll');
    var headers = {
      'Cookie': 'ci_session=dc80230d43277d5706a77fc587d26ae4a1068e10'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getPharmaProductsCategory}'));
    request.fields.addAll({
      'roll': '$roll',
      'company_id': widget.companyid.toString()
    });
    print('____dgfdgdfdgfdgfd______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response=========ggfgg==>${roll}");
      final finalResult = GetPharmaProductsCategory.fromJson(
          json.decode(result));
      print("this is a response===========>${finalResult}");
      setState(() {
        getPharmaProductsCategory = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  getPharmaProductsCategoryNew() async {
    var headers = {
      'Cookie': 'ci_session=2c9c44fe592a74acad0121151a1d8648d7a78062'
    };
    var request = http.Request(
        'GET', Uri.parse('${ApiService.getPharmaProductsCategoryNew}'));
    request.headers.addAll(headers);

    print("fieldss===========>${request.url}");
    http.StreamedResponse response = await request.send();
    print("response.statusCode===========>${response.statusCode}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    roll = preferences.getString('roll');
    print('__________${roll}_____________');
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response=========ggfgg==>${roll}");
      final finalResult =
      GetPharmaProductsCategory.fromJson(json.decode(result));
      print("this is a response===========>${finalResult}");
      setState(() {
        pharmaProductList = finalResult.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context: context, text:"${widget.companyName}", isTrue: true, ),
        body: SingleChildScrollView(
          child:getPharmaProductsCategory == null || getPharmaProductsCategory == " " ? Center(child: CircularProgressIndicator()):Column(
            children: <Widget>[

              isLodding
                  ? const Center(
                child: SingleChildScrollView(),
              )
                  : getPharmaProductsCategory!.data!.isEmpty? const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("NO Data Found !!"),
                ),
              ) : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: getPharmaProductsCategory!.data!.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PharmaProductsDataScreen(pharmaCategory: getPharmaProductsCategory?.data?[index].id,ProdectName: getPharmaProductsCategory?.data?[index].name, ),
                        ));

                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.09,
                        decoration: BoxDecoration(
                            color: colors.transparent,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            '${getPharmaProductsCategory!.data![index].name}',
                            style:
                            const TextStyle(fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),



              //SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
