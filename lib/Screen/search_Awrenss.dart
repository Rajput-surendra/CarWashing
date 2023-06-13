// import 'package:flutter/cupertino.dart';
//
// class SearchList extends StatefulWidget {
//   const SearchList({Key? key}) : super(key: key);
//
//   @override
//   State<SearchList> createState() => _SearchListState();
// }
//
// class _SearchListState extends State<SearchList> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       floatingActionButton: FloatingActionButton(
//
//       appBar: AppBar(
//         centerTitle: true,
//         leading:InkWell(
//             onTap: (){
//               Navigator.pop(context);
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(Icons.arrow_back_ios_new_outlined,color: colors.whiteTemp,),
//             )
//         ),
//         title: Text("Awareness Inputs"),
//         actions: [
//           InkWell(
//             onTap: (){
//               // Navigator.pop(context);
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: InkWell(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
//                   },
//                   child: Icon(Icons.search,color: colors.whiteTemp,)),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 50,
//                   child: TextFormField(
//                       controller: searchController,
//                       decoration:InputDecoration(
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                           ),
//                           prefixIcon:  Icon(Icons.search,color: colors.black54,),
//                           contentPadding: EdgeInsets.only(top: 5),
//                           hintText: "Search...."
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           getSearchListApi(value);
//                         });
//                       }
//                   ),
//                 ),
//               ),
//               Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   SizedBox(
//                     height: 200,
//                     width: double.maxFinite,
//                     child: isSliderLoading ? const Center(child: CircularProgressIndicator(
//                       color: colors.primary,
//                     )):_CarouselSlider1(),
//                   ),
//                   Positioned(
//                     bottom: 20,
//                     // left: 80,
//                     child:
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children:  _buildDots(),),
//                   ),
//
//                 ],
//
//               ),
//               _segmentButton(),
//               // _sliderModel== null ? Center(child: CircularProgressIndicator(),) :_CarouselSlider1(),
//               // SizedBox(height: 5,),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children:  _buildDots(),),
//               // customTabbar(),
//               SizedBox(
//                 // height: MediaQuery.of(context).size.height/1.0,
//                   child: isScreenLoading ? const Center(child: CircularProgressIndicator())
//                       : aaaaaModel?.data.mPoster.isEmpty ?? true ? Center(child: Text('Poster not available'),) : selectedSegmentVal == 0
//                       ?ListView.builder(
//                     // scrollDirection: Axis.vertical,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       reverse: true,
//                       itemCount: aaaaaModel!.data.mPoster.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return  getPosterList(aaaaaModel?.data.mPoster, index);
//                       })
//                       : selectedSegmentVal == 1
//                       ? ListView.builder(
//                     // scrollDirection: Axis.vertical,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       reverse: true,
//                       itemCount: aaaaaModel!.data.booklets.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return  bookletsList(aaaaaModel?.data.booklets, index);
//                       })
//                       : selectedSegmentVal == 2
//                       ?  ListView.builder(
//                     // scrollDirection: Axis.vertical,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       reverse: true,
//                       itemCount: aaaaaModel!.data.leaflets.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return  getLeafletList(aaaaaModel?.data.leaflets, index);
//                       })
//                       : selectedSegmentVal == 3
//                       ?ListView.builder(
//                     // scrollDirection: Axis.vertical,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       reverse: true,
//                       itemCount: aaaaaModel!.data.poster.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return   getMotimationList(aaaaaModel?.data.poster, index);
//                       })
//                       : selectedSegmentVal == 4
//                       ? ListView.builder(
//                     // scrollDirection: Axis.vertical,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       reverse: true,
//                       itemCount: aaaaaModel?.data.video.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return getVideoList(aaaaaModel?.data.video,index);
//                       }):SizedBox()),
//               SizedBox(height: 50,)
//               //
//               //   : selectedSegmentVal == 5
//               //   ?ListView.builder(
//               // // scrollDirection: Axis.vertical,
//               //   physics: NeverScrollableScrollPhysics(),
//               //   shrinkWrap: true,
//               //   reverse: true,
//               //   itemCount: GetAwrenessModel?.data?.awareness?.length,
//               //   itemBuilder: (BuildContext context, int index) {
//               //     return productCustomCards();
//               //      });
//
//             ],
//           )
//       ),
//     )
//   }
// }
