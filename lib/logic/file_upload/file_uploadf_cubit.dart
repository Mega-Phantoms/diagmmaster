import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:researchapp/env.dart';
import 'package:http/http.dart' as http;
import '../../services/file_upload.dart';

part 'file_uploadf_state.dart';

class FileUploadfCubit extends Cubit<FileUploadfState> {
  FileUploader fileUploader;

  FileUploadfCubit({required this.fileUploader}) : super(FileUploadfInitial());

  Future<String> fileupload(File file, String path, String jwt) async {
    emit(FileUploadLoad());
    String file_id = "";
    var response;
    try {
      response = await fileUploader.FileUpload(file, path);
      file_id = response["file_id"];
      emit(FileUploadSuccess(id: file_id));
      print("abcd");
      var response2 = await http.post(
        Uri.parse(SERVER_URL + path),
        headers: {
          'X-API-Key': API_KEY,
          'Content-Type': 'application/json',
          'x-access-token': jwt
        },
        body: jsonEncode({"ImgID": file_id}),
      );
      print("efg");
      var res = jsonDecode(response2.body);
      print(res);
      if (res["result"] == "true") {
        emit(PredictionTrue(file: file));
      } else {
        emit(PredictionFalse(file: file));
      }
    } on Exception {
      emit(FileUploadError());
    }

    return file_id;
  }

  void reload() {
    emit(FileUploadfInitial());
  }
}
