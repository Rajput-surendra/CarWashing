import 'package:doctorapp/New_model/CarWashing/Accessories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class AccessoriesDetailsSrreen extends StatefulWidget {
  AccessoriesModel? accessoriesListModel;
   AccessoriesDetailsSrreen({Key? key,this.accessoriesListModel}) : super(key: key);
  @override
  State<AccessoriesDetailsSrreen> createState() => _AccessoriesDetailsSrreenState();
}
class _AccessoriesDetailsSrreenState extends State<AccessoriesDetailsSrreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.darkIcon,
      appBar: customAppBar(context: context, text:"Accessories Details", isTrue: true, ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height/2.9,
          decoration: BoxDecoration(
            color: colors.whiteTemp,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child: Image.network("${widget.accessoriesListModel!.data!.first.logo}")),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(height: 5,),
                             Text("Name:"),
                             SizedBox(height: 5,),
                             Text("Description"),
                             SizedBox(height: 5,),
                             Text("Model"),
                             SizedBox(height: 5,),
                             Text("Brand"),
                             SizedBox(height: 5,)
                           ],
                         ),
                         Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5,),
                              Text("${widget.accessoriesListModel!.data!.first.name}",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold)),
                              SizedBox(height: 5,),
                              Container(
                                width: 70,
                                  child: Text("${widget.accessoriesListModel!.data!.first.description}",overflow: TextOverflow.ellipsis,style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold))),
                              SizedBox(height: 5,),
                              Text("${widget.accessoriesListModel!.data!.first.model}",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold)),
                              SizedBox(height: 5,),
                              Text("${widget.accessoriesListModel!.data!.first.brand}",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold)),
                              SizedBox(height: 5,),
                            ],
                          )
                       ],
                     ),
                   )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
