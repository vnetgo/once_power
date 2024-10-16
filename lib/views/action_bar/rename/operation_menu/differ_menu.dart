import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/easy_chip.dart';

class DifferMenu extends ConsumerWidget {
  const DifferMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(currentModeProvider);
    // 保留模式时也应该出现修改输入框
    if (mode == FunctionMode.reserve) {
      final currentReserveType = ref.watch(currentReserveTypeProvider);
      bool enable =
          !ref.watch(matchClearProvider) && !ref.watch(modifyClearProvider);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...ReserveType.values.map(
            (e) {
              return EasyChip(
                label: e.value,
                selected: currentReserveType.contains(e),
                enable: enable,
                onTap: () {
                  ref.read(currentReserveTypeProvider.notifier).update(e);
                  ref.watch(matchControllerProvider).clear();
                  updateName(ref);
                },
              );
            },
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...ReplaceType.values.map(
          (e) {
            return EasyChip(
              label: e.value,
              selected: ref.watch(currentReplaceTypeProvider).contains(e),
              // enable: false,
              onTap: () {
                ref.read(currentReplaceTypeProvider.notifier).update(e);
                updateName(ref);
              },
            );
          },
        ),
      ],
    );
  }
}