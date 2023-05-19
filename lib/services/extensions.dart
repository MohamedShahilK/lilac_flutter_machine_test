// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:external_path/external_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:lilac_flutter_machine_test/utils/custom_popup.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getUserId() async {
  final User? userData = FirebaseAuth.instance.currentUser;
  if (userData == null) {
    return '';
  } else {
    return userData.uid;
  }
}

DateTime convertToDateTime(var inputData) {
  if (inputData is Timestamp) {
    return inputData.toDate();
  } else if (inputData is DateTime) {
    return inputData;
  } else {
    return DateTime.now().subtract(Duration(days: 20));
  }
}

// Encrypted file stores in "dowloads/secret/"
encryptFile(String inFilePath, String filename) async {
  showTextMessageToaster(
      'Encryption Started.Don\'t close the app or touch anywhere');
  // File inFile = File("video.mp4");
  File inFile = File(inFilePath);
  // File outFile = File("videoenc.aes");
  var dir = await DownloadsPath.downloadsDirectory();
  // File outFile = File("${dir!.path}/$filename.aes");
  File outFile = File("${dir!.path}/secret/$filename.aes");

  bool outFileExists = await outFile.exists();

  if (!outFileExists) {
    await outFile.create();
  }

  final videoFileContents = await inFile.readAsStringSync(encoding: latin1);

  final key = Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(videoFileContents, iv: iv);
  await outFile.writeAsBytes(encrypted.bytes);
  showTextMessageToaster('Encryption Completed');
  print('encryption completed');
}

// Decryption
decryptFile(String fileName) async {
 
  var dir = await DownloadsPath.downloadsDirectory();
  // File inFile = File("videoenc.aes");
  File inFile = File("${dir!.path}/secret/$fileName.aes");
  // File outFile = File("videodec.mp4");

  // File outFile = File("${dir.path}/secret/${fileName}_decrypted.mp4");
  File outFile = File("${dir.path}/secret/_decrypted.mp4");

  bool outFileExists = await outFile.exists();

  if (!outFileExists) {
     showTextMessageToaster(
      'Decryption Started.Don\'t close the app or touch anywhere');
    await outFile.create();
  }else{
    // if decryted file already there, then don't again do it
    return;
  }

  final videoFileContents = await inFile.readAsBytesSync();

  final key = Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encryptedFile = Encrypted(videoFileContents);
  final decrypted = encrypter.decrypt(encryptedFile, iv: iv);

  final decryptedBytes = latin1.encode(decrypted);
  await outFile.writeAsBytes(decryptedBytes);
  showTextMessageToaster('Decryption Completed');
  print('decryption completed');
}

deleteFileFromDevice(String filename) async {
  // final directory = await getDownloadsDirectory();
  var path = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOADS);
  print('path $path');

  File file;

  if (filename == '_decrypted') {
    // print('555555555555555555555555555555555555555');
    file = File('$path/secret/$filename.mp4');
    try {
      file.delete();
      // showTextMessageToaster('Deleted');
    } catch (e) {
      // return 0;
      print(e);
    }
    return;
  } else {
    file =
        File('$path/secret/${filename.toLowerCase().replaceAll(' ', '')}.mp4');
    try {
      file.delete();
      // showTextMessageToaster('Deleted');
    } catch (e) {
      // return 0;
      print(e);
    }
  }

  // try {
  //   file.delete();
  //   showTextMessageToaster('Deleted');
  // } catch (e) {
  //   // return 0;
  //   print(e);
  // }
}
