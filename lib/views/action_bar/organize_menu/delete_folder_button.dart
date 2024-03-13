import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

class DeleteFolderButton extends ConsumerWidget {
  const DeleteFolderButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NotificationInfo> errorList = [];
    bool saveLog = ref.watch(saveLogProvider);
    TextEditingController controller = ref.watch(targetControllerProvider);

    void delete(Directory directory) {
      try {
        directory.deleteSync();
        if (saveLog) {
          final fileName = formatDateTime(DateTime.now()).substring(0, 14);
          final log = File(path.join(
              controller.text, '${S.of(context).deleteLog}-$fileName.log'));
          String contents = S.of(context).deleteInfo(directory.path);
          log.writeAsStringSync('$contents\n', mode: FileMode.append);
        }
      } catch (e) {
        errorList.add(NotificationInfo(
          file: directory.path,
          message: '${S.of(context).deleteFailed}: $e',
        ));
      }
    }

    void deleteFolders(String folderPath) {
      var directory = Directory(folderPath);
      if (directory.existsSync()) {
        bool isEmpty = directory.listSync().isEmpty;
        if (isEmpty) return delete(directory);
        directory.listSync().forEach((file) {
          if (FileSystemEntity.isDirectorySync(file.path)) {
            deleteFolders(file.path);
          }
        });
        if (directory.listSync().isEmpty) delete(directory);
      }
    }

    void showNotification() {
      if (errorList.isEmpty) {
        NotificationMessage.show(
          S.of(context).deleteSuccessful,
          S.of(context).successInfo,
          [],
          NotificationType.success,
        );
      } else {
        NotificationMessage.show(
          S.of(context).deleteFailed,
          S.of(context).failureInfo,
          errorList,
          NotificationType.failure,
        );
      }
    }

    void deleteEmptyFolder() {
      List<FileInfo> files = ref.read(fileListProvider);
      for (var file in files) {
        if (file.type != FileClassify.folder) return;
        deleteFolders(file.filePath);
      }
      showNotification();
    }

    return ElevatedButton(
      onPressed: ref.watch(fileListProvider).isEmpty ? null : deleteEmptyFolder,
      child: Text(S.of(context).deleteEmptyFolder),
    );
  }
}
