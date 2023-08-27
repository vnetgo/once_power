import 'package:once_power/constants/keys.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select.g.dart';

@riverpod
class InputLength extends _$InputLength {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isLength) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isLength, state);
  }
}

@riverpod
class MatchCase extends _$MatchCase {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isCase) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isCase, state);
  }
}

@riverpod
class DateRename extends _$DateRename {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isDate) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isDate, state);
  }
}

@riverpod
class CyclePrefix extends _$CyclePrefix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isPrefixCycle) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isPrefixCycle, state);
  }
}

@riverpod
class CycleSuffix extends _$CycleSuffix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSuffixCycle) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSuffixCycle, state);
  }
}

@riverpod
class SwapPrefix extends _$SwapPrefix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isPrefixSwap) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isPrefixSwap, state);
  }
}

@riverpod
class SwapSuffix extends _$SwapSuffix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSuffixSwap) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSuffixSwap, state);
  }
}

@riverpod
class ModifyExtension extends _$ModifyExtension {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class AppendMode extends _$AppendMode {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isAppend) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isAppend, state);
  }
}

@riverpod
class AddFolder extends _$AddFolder {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isFolder) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isFolder, state);
  }
}

@riverpod
class SaveConfig extends _$SaveConfig {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSave) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSave, state);
  }
}

// TODO 底部取消按钮，似乎没用
@riverpod
class Cancel extends _$Cancel {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
bool selectAudio(SelectAudioRef ref) {
  List<RenameFile> audioList = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.audio)
      .toList();
  int check = audioList.where((e) => e.checked == true).length;
  return check >= audioList.length;
}

@riverpod
bool selectFolder(SelectFolderRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.folder)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectImage(SelectImageRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.image)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectOther(SelectOtherRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.other)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectText(SelectTextRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.text)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectVideo(SelectVideoRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.video)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}
