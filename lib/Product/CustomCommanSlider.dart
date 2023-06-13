import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'Ipca_products2.dart';

class CustomCommanSlider extends StatefulWidget {
  const CustomCommanSlider({Key? key, required this.file, required this.typeID}) : super(key: key);
  final String file;
  final String typeID;

  @override
  State<CustomCommanSlider> createState() => _CustomCommanSliderState();
}

class _CustomCommanSliderState extends State<CustomCommanSlider> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    Uri uri = Uri.parse(widget.file ?? '');
    String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
    if (typeString == 'mp4') {
      videoPlayerController = VideoPlayerController.network(widget.file);
      videoPlayerController!.initialize();
      videoPlayerController!.setLooping(false);
      videoPlayerController!.play();
    }
    super.initState();
  }

  bool? isPlaying ;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('____this ios mooo smoks______${widget.typeID}_________');
    Uri uri = Uri.parse(widget.file);
    String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
// height: 180,
// width: MediaQuery.of(context).size.width,
        child: typeString == "jpg"
            ? InkWell(
          onTap: () async{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>IpcaProductScreen2(PharmaProduct: widget.typeID,)));
            // Uri url = Uri.parse(widget.typeID);
            // if (!await launchUrl(
            //   url,
            //   mode: LaunchMode.inAppWebView,
            //   webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
            // )) {
            //   throw Exception('Could not launch $url');
            // }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1),
            child: Image.network(
              widget.file,
              fit: BoxFit.fill,
            ),
          ),
        )
            : InkWell(
          onTap: ()async {
            widget.typeID;
            print('____typeId______${widget.typeID}_________');
          },

          child: Stack(
            fit: StackFit.expand,
            children: [
              AspectRatio(
                aspectRatio: videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(videoPlayerController!),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: InkWell(
                      onTap: (){
                        if (videoPlayerController!.value.isPlaying){
                          videoPlayerController!.pause();
                          isPlaying =false ;
                        }else{
                          isPlaying = true;
                          videoPlayerController!.play();
                        }
                        setState(() {

                        });
                      },
                      child: Icon(isPlaying ?? true ?Icons.pause  : Icons.play_arrow , color: Colors.white)))
            ],),
        )
    );
  }
}