import 'package:template/source/export.dart';

class SlideBanner {
  final String foodBanner;
  final Widget content;

  SlideBanner(this.foodBanner, this.content);
}

List<SlideBanner> slideBanner = [
  SlideBanner(
      Assets.firstBanner,
      Positioned(
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                  content: 'Get 25% Cashback',
                  fontSize: 15,
                  color: AppColor.globalPink),
              const CustomText(content: 'on grocery from our retailers\n'),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                    alignment: Alignment.center,
                    height: 28,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(800),
                        color: AppColor.globalPink),
                    child: const CustomText(
                        content: 'Code: CVB25',
                        fontSize: 10,
                        color: Colors.white)),
              )
            ],
          ))),
  SlideBanner(
      Assets.middleBanner,
      const Positioned(
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  content: 'Pizza Party',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  content: 'Enjoy pizza from Johnny\nand get up to 30% off',
                  fontSize: 12,
                  color: Colors.grey),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  content: '\nStarting from\n',
                  fontSize: 10,
                  color: Colors.grey),
              CustomText(content: '\$10', color: AppColor.globalPink)
            ],
          ))),
  SlideBanner(
      Assets.lastBanner,
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const CustomText(
            content: '30% FLAT',
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        const CustomText(content: 'on any IceCreams', fontSize: 12),
        Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
                alignment: Alignment.center,
                height: 28,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(800),
                    color: AppColor.buttonShadowBlack),
                child: const CustomText(
                    content: 'Shop Now', fontSize: 10, color: Colors.white)))
      ])),
];
