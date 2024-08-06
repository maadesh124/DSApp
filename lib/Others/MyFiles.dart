// ignore_for_file: curly_braces_in_flow_control_structures

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
      bool isGranted=await getPermission();
      if(isGranted)
      {
      result=await FilePicker.platform.pickFiles();
      return File(result!.files.single.path!);
      }
    }
  }

}


//picks a file and uploads it to specified folder in FirebaseStorage ,
// folder path should not contain / at ends,example f1/f2 .
Future<void> pickAndUpload(String path,{String? name})async
{
  File? file=await pickFile();
  
  if(file!=null)
  {
    name=name??file.path.split('/').last.split('.')[0];
      await FirebaseStorage.instance.ref().child('/$path/$name').putFile(file);
  }
   
}


class TestFile extends StatelessWidget {
  const TestFile({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: pickFile, child:Text('pick'));
  }
}