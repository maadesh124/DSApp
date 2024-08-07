
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/Others/Functions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfviewer extends StatefulWidget {

  Model model;
  String docName;
  Pdfviewer({super.key,required this.model,required this.docName});

  @override
  State<Pdfviewer> createState() => _PdfviewerState();
}

class _PdfviewerState extends State<Pdfviewer> {

String url='';
bool gotData=false;
Future<void> initialize()async
{
 url=await FirebaseStorage.instance.
  ref().child('/${widget.model.collectionType}/${widget.model.getDocId()}/Documents/${widget.docName}').
  getDownloadURL();

  setState(() {
    gotData=true;
  });
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
        !gotData?Center(child: CircularProgressIndicator(),):SfPdfViewer.network(url);
  }
}