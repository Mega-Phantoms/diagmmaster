import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:researchapp/env.dart';
import 'package:researchapp/ui/widgets.dart';
import 'package:image_downloader/image_downloader.dart';

class Report extends StatefulWidget {
  String name;
  String gender;
  String Age;
  String diseases;
  String prediction;
  String ImgFile;

  Report(
      {required this.name,
      required this.Age,
      required this.diseases,
      required this.gender,
      required this.ImgFile,
      required this.prediction})
      : super();

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  Future<void> showImage() async {
    var imageId = await ImageDownloader.downloadImage(
        IMG_UPLOAD + "/download?id=" + widget.ImgFile);
    var path = await ImageDownloader.findPath(imageId!);
    await ImageDownloader.open(path!  );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBarr,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Report",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                Text('Name : ${widget.name}'),
                Text('Age : ${widget.Age}'),
                Text('Report For : ${widget.diseases}'),
                Text('Gender  : ${widget.gender}'),
                Text('Predicted as :${widget.prediction}'),
                // FutureBuilder(
                //   future:()=>{ ImageDownloader.downloadImage(IMG_UPLOAD+"/download?id="+widget.ImgFile)},
                //   builder: ((context, snapshot)as {
                //   if(snapshot.connectionState==ConnectionState.active || snapshot.connectionState==ConnectionState.none || snapshot.connectionState==ConnectionState.waiting){
                //     return Container(child: Text("Please wait for image"),);
                //   }else if(snapshot.connectionState==ConnectionState.done){
                //     var data=snapshot.data;

                //   }
                // }))
              ],
            ),
          ),
        ));
  }
}
