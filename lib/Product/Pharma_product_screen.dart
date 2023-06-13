import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/New_model/GetSliderModel.dart';
import 'package:doctorapp/New_model/New_slider_model.dart';
import 'package:doctorapp/New_model/pharma_products_category_response.dart';
import 'package:doctorapp/Screen/AddToCart.dart';
import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:doctorapp/Product/add_product.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:doctorapp/widgets/widgets/commen_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/Get_company_model.dart';
import 'CatListData.dart';
import 'CustomCommanSlider.dart';
import 'Ipca_products1.dart';
import 'package:http/http.dart' as http;

class PharmaProductScreen extends StatefulWidget {
  const PharmaProductScreen({Key? key}) : super(key: key);

  @override
  State<PharmaProductScreen> createState() => _PharmaProductScreenState();
}

class _PharmaProductScreenState extends State<PharmaProductScreen> {
  GetSliderModel? _sliderModel;
  GetPharmaProductsCategory? _pharmaProductsCategory;

  String? roll;
  getProductroll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    roll = preferences.getString('roll');
    print("this is reeeeeeeeererererer==============>${roll}");
  }

  List <PharmaProductCategoryDataList> pharmaProductList = [];
  List <PharmaProductCategoryDataList> pharmaProductListOld = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderApi();
    getCompanyName();
    getProductroll();
     getPharmaProductsCategory();
     //getPharmaProductsCategoryNew();
  }
 bool isLodding =  false;
  TextEditingController  searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context: context, text:"Pharma Products", isTrue: true, ),
        bottomSheet: roll == '2'? Container(
          height: 60,
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductSrcreen(categoryData: pharmaProductListOld)));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      const MaterialStatePropertyAll<Color>(
                          Colors.indigo),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10.0)))),
                  child: const Text(
                    'Create Product Catalogue',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ),
          ),
        ):SizedBox(),
        body: SingleChildScrollView(
          child: getCompanyModel == null  || getCompanyModel == " " ? Center(child: CircularProgressIndicator()):Column(
            children: <Widget>[
              newSliderModel == null
                  ? const Center(
                      child: Text("No Data Found!! "),
                    )
                  : InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>PharmaProductsDataScreen(SliderId:_sliderModel!.data!.first.typeId)));
                    },
                    child: CarouselSlider(
                      options: CarouselOptions(
                          viewportFraction: 1.0,
                          onPageChanged: (index, result) {
                            setState(() {
                              _currentPost = index;
                            });
                          },
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 150),
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                          height: 200.0),
                      items: newSliderModel!.data!.map((item) {
                        return
                          Builder(
                          builder: (BuildContext context) {
                            return
                              CustomCommanSlider(
                                file: item.image ?? '',
                                typeID: item.typeId ?? '');

                          },
                        );
                      }).toList(),
                    ),
                  ),
              /*SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Ipca laboratories ltd',style: TextStyle(fontWeight: FontWeight.w700),),
                  SizedBox(width: 10,),
                  Container(height: 10,width: 10,
                    decoration:BoxDecoration(
                        color: colors.red,
                        borderRadius: BorderRadius.circular(20)) ,)
                ],
              ),*/
              SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  _buildDots(),),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'Search here'),
                    onChanged: (value) {
                      setState(() {
                        searchProduct(value);
                      });
                    },
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              isLodding
                  ? const Center(
                      child: SingleChildScrollView(),
                    )
                  : companyList.isEmpty ? Center(
                child: CircularProgressIndicator()
              ) : SizedBox(
                height: MediaQuery.of(context).size.height/1.0,
                child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: companyList.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CatListData(companyid: getCompanyModel?.data?[index].id,companyName: getCompanyModel?.data?[index].companyName),
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
                                    '${companyList[index].companyName}',
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
              ),

              //SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  int _currentPost =  0;

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < (_sliderModel?.data?.length ?? 10); i++) {
      dots.add(
        Container(
          margin: EdgeInsets.all(1.5),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPost == i
                ? colors.primary
                : Colors.grey.withOpacity(0.5),
          ),
        ),
      );
    }
    return dots;
  }
  NewSliderModel ? newSliderModel;
  getSliderApi() async {
    String type = '/pharma_product_slide';
    var headers = {
      'Cookie': 'ci_session=2c9c44fe592a74acad0121151a1d8648d7a78062'
    };
    var request =
        http.Request('GET', Uri.parse('${ApiService}$type'));
    request.headers.addAll(headers);
    print("fieldss===========>${request.url}");
    http.StreamedResponse response = await request.send();
    print("response.statusCode===========>${response.statusCode}");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========>${result}");
      final finalResult = NewSliderModel.fromJson(json.decode(result));
      print("this is a response=====dfdgdfgfdgfdgfd======>${result}");
      setState(() {
        newSliderModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  List<CompanyDataList> companyList= [];
  GetCompanyModel? getCompanyModel;
  getCompanyName() async {
    var headers = {
      'Cookie': 'ci_session=e5dbfebfc51701fd8aba3e57be6c399b3a13750d'
    };
    var request = http.Request('GET', Uri.parse('${ApiService.getCompaniesApi}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
   var result =    await response.stream.bytesToString();
   var finalResult  = GetCompanyModel.fromJson(json.decode(result));
   print('____sdsdfsdd______${finalResult}_________');
   setState(() {
     getCompanyModel = finalResult;
    companyList = finalResult.data ?? [];
   });
    }

    else {
    print(response.reasonPhrase);
    }

  }
  getPharmaProductsCategory() async {
    var headers = {
      'Cookie': 'ci_session=2c9c44fe592a74acad0121151a1d8648d7a78062'
    };
    var request = http.Request(
        'POST', Uri.parse('${ApiService.getPharmaProductsCategory}'));
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
        pharmaProductListOld = finalResult.data ?? [];
      });
    } else {
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
  searchProduct(String value) {
    if (value.isEmpty) {
      getCompanyName();
    } else {
      final suggestions = companyList.where((element) {
        final productTitle = element.companyName!.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      companyList = suggestions;
      setState(() {
      });
    }
  }
}

