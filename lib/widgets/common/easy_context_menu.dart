import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/utils/utils.dart';
import 'package:window_manager/window_manager.dart';

class EasyContextMenu extends StatelessWidget {
  const EasyContextMenu(
      {super.key,
      required this.count,
      required this.menu,
      required this.child});

  final int count;
  final Widget menu;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const double safeW = 12;
    const double safeH = 32;
    double width = 80;
    Locale? cacheLocale = StorageUtil.getLocale(AppKeys.locale);
    if (cacheLocale?.languageCode != 'zh') width = 120;
    double height = safeH * count;

    return GestureDetector(
      onSecondaryTapDown: (detail) async {
        Size size = await windowManager.getSize();
        Log.i('窗口尺寸：$size，鼠标坐标：${detail.globalPosition}');
        if (!context.mounted) return;
        showModal(
          context: context,
          configuration: const FadeScaleTransitionConfiguration(
            barrierColor: Colors.transparent,
          ),
          builder: (BuildContext context) {
            double x = detail.globalPosition.dx;
            double y = detail.globalPosition.dy;
            if (x + width > size.width - safeW) x -= width;
            if (y + height > size.height - safeH) y -= height;
            return UnconstrainedBox(
              alignment: Alignment.topLeft,
              child: Container(
                width: width,
                height: height,
                margin: EdgeInsets.only(left: x, top: y),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Colors.black.withValues(alpha: .2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: menu,
                ),
              ),
            );
          },
        );
      },
      child: child,
    );
  }
}
