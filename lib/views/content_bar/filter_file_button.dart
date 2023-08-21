import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';

class FilterFileButton extends ConsumerWidget {
  const FilterFileButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isCheck(FileClassify classify) {
      if (classify == FileClassify.audio) return ref.watch(selectAudioProvider);
      if (classify == FileClassify.other) return ref.watch(selectOtherProvider);
      if (classify == FileClassify.image) return ref.watch(selectImageProvider);
      if (classify == FileClassify.text) return ref.watch(selectTextProvider);
      if (classify == FileClassify.video) return ref.watch(selectVideoProvider);
      return ref.watch(selectFolderProvider);
    }

    void remove() {
      ref.read(fileListProvider.notifier).removeUncheck();
      Navigator.of(context).pop();
    }

    DropdownMenuItem deleteUncheck() {
      return DropdownMenuItem(
        value: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
          child: InkWell(
            onTap: remove,
            child: const Text('删除未选择', style: TextStyle(color: Colors.red)),
          ),
        ),
      );
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.filter_alt_rounded,
          size: 24,
          color: AppColors.icon,
        ),
        items: [
          deleteUncheck(),
          ...ref.watch(classifyListProvider).map(
            (e) {
              return DropdownMenuItem(
                value: e,
                child: StatefulBuilder(
                  builder: (context, setState) => Row(
                    children: [
                      Checkbox(
                        value: isCheck(e),
                        onChanged: (v) {
                          ref
                              .read(fileListProvider.notifier)
                              .checkPart(e, !isCheck(e));
                          setState(() {});
                        },
                      ),
                      Text(e.value),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ],
        onChanged: (value) {},
        dropdownStyleData: DropdownStyleData(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          offset: const Offset(-48, 0),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
        ),
      ),
    );
  }
}