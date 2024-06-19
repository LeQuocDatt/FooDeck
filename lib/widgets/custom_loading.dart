import 'package:template/source/export.dart';

Widget customLoading() {
  return const Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColor.globalPink,
          ),
          CustomText(content: 'Please wait')
        ],
      ),
    ),
  );
}
