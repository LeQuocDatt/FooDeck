import 'package:template/source/export.dart';

enum Toast { success, error }

customSnackBar(BuildContext context, Toast type, String content,
    [int duration = 1500]) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.none,
        duration: Duration(milliseconds: duration),
        backgroundColor: type == Toast.success
            ? AppColor.globalPinkShadow
            : AppColor.buttonShadowBlack,
        content: CustomText(
          content: content,
          textOverflow: TextOverflow.visible,
        )));
}
