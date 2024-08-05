import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';



Future<bool> getPermission() async
{
  int sdkVer=32;
  bool isGranted;
  AndroidDeviceInfo androidDeviceInfo= await DeviceInfoPlugin().androidInfo;
  sdkVer=androidDeviceInfo.version.sdkInt;

  if(sdkVer>=29)
  isGranted= await Permission.manageExternalStorage.request().isGranted;
  else
  isGranted=await Permission.storage.request().isGranted;

  return isGranted;
}

Future<File?> pickFile()async
{
  FilePickerResult? result;
 
print(FilePicker.platform.toString());
// Platform.isAndroid;
  if(kIsWeb)
  {
    result=await FilePicker.platform.pickFiles();
  }else 
  {
    if(Platform.isAndroid)
    {
      print('\n\n\n\n**********android***********\n\nn\no\nm\n');
      bool isGranted=await getPermission();
      print(isGranted);
      result=await FilePicker.platform.pickFiles();
      if(result!=null)
      await FirebaseStorage.instance.ref().child('folder/sample').putFile(File(result!.files.single.path!));
    }
  }
  


  //  File? picked=result!=null?File(result.files.single.path!):null;

 
}



class TestFile extends StatelessWidget {
  const TestFile({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: pickFile, child:Text('pick'));
  }
}