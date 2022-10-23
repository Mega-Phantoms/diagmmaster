part of 'file_uploadf_cubit.dart';

@immutable
abstract class FileUploadfState {}

class FileUploadfInitial extends FileUploadfState {}

class FileUploadLoad extends FileUploadfState {}

class FileUploadSuccess extends FileUploadfState {
  String id;
  FileUploadSuccess({required this.id});
}

class PredictionTrue extends FileUploadfState {
  File file;
  PredictionTrue({required this.file});
}

class PredictionFalse extends FileUploadfState {
  File file;
  PredictionFalse({required this.file});
}

class FileUploadError extends FileUploadfState {}
