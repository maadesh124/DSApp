

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/Others/Location.dart';
import 'package:fp4/Others/Functions.dart';
import 'package:fp4/Others/MyFiles.dart';

class ImageCarousel extends StatefulWidget {

  Model model;
  double size;
  ImageCarousel({super.key,required this.model,required this.size});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
List<Image> images=[];
bool gotData=false;
bool isLoop=true;
String loc='';
  Future<void> initialize()async
  {
      final refs=await FirebaseStorage.instance.ref('/${widget.model.collectionType}/${widget.model.getDocId()}/Images/').
      listAll();
      if(refs.items.isEmpty)
      {
        images.add(Image.asset('assets/images/img.png'));
        setState(() {
          gotData=true;
          isLoop=false;
        });
        return;
      }
      for (Reference ref in refs.items)
      {
      String url=  await ref.getDownloadURL();
      images.add(Image.network(url,fit: BoxFit.cover,));
      }
      
      setState(() {
        gotData=true;
      });

    // pickFile().then((File? file)
    // {
    //   setState(() {
    //     loc=file!.path;
    //   });
    // });

    // getcurrentLocation().then((val)
    // {
    //   setState(() {
    //     loc=val;
    //   });
    // });

  }

  @override
  void initState()
  {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
        !gotData?Center(child: CircularProgressIndicator(),):
        ClipRRect(borderRadius: BorderRadius.circular(25),
          child: ImageSlideshow(children: images,width: widget.size,height: widget.size,
          indicatorColor: PageConstants.BLACK50,indicatorBackgroundColor: PageConstants.BLACK20,
          autoPlayInterval: 3000,isLoop: isLoop,),);
  }
}