import 'dart:io';

import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResourceProvider extends ChangeNotifier {
  ResourceProvider({
    required FirebaseStorage storage,
    required SharedPreferences prefs,
  })  : _storage = storage,
        _prefs = prefs;
  final FirebaseStorage _storage;
  final SharedPreferences _prefs;
  Resource? _resource;
  bool _downloading = false;
  bool _loading = false;
  double _percentage = 0;
  double get percentage => _percentage;
  bool get loading => _loading;
  bool get downloading => _downloading;
  Resource? get resource => _resource;
  String get _pathKey => 'material_file_path${_resource!.id}';
  void init(Resource resource) {
    if (_resource == resource) return;
    _resource = resource;
  }

  Future<File> _getFileFromCache() async {
    final cachedFilePath = _prefs.getString(_pathKey);
    return File(cachedFilePath!);
  }

  bool get fileExists {
    final cachedFilePath = _prefs.getString(_pathKey);
    if (cachedFilePath == null) return false;
    final file = File(cachedFilePath);
    final fileExists = file.existsSync();
    if (!fileExists) _prefs.remove(_pathKey);
    return fileExists;
  }

  Future<File?> downloadAndSaveFile() async {
    _loading = true;
    _downloading = true;
    notifyListeners();
    final cacheDir = await getTemporaryDirectory();
    final file = File(
      '${cacheDir.path}/'
      '${_resource!.id}.${_resource!.fileExtension}',
    );
    if (file.existsSync()) return file;
    try {
      final ref = _storage.refFromURL(_resource!.fileURL);
      var successful = false;
      final downloadTask = ref.writeToFile(file);
      downloadTask.snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            _percentage =
                taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
            notifyListeners();
          case TaskState.paused:
            break;
          case TaskState.success:
            _downloading = false;
            await _prefs.setString(_pathKey, file.path);
            successful = true;
          case TaskState.canceled:
            successful = false;
          case TaskState.error:
            successful = false;
        }
      });
      await downloadTask;
      return successful ? file : null;
    } catch (e) {
      return null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteFile() async {
    if (fileExists) {
      final file = await _getFileFromCache();
      await file.delete();
      await _prefs.remove(_pathKey);
    }
  }

  Future<void> openFile() async {
    if (fileExists) {
      final file = await _getFileFromCache();
      await OpenFile.open(file.path);
    }
  }
}
