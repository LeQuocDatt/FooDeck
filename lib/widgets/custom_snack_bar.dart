import 'package:template/source/export.dart';

enum Toast { success, error }

customSnackBar(BuildContext context, Toast type, String content) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.none,
        duration: const Duration(milliseconds: 1500),
        backgroundColor: type == Toast.success
            ? AppColor.globalPinkShadow
            : AppColor.buttonShadowBlack,
        content: CustomText(content: content)));
}
