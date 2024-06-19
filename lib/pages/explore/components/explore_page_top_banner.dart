import 'package:template/source/export.dart';

class TopListShopping extends StatelessWidget {
  const TopListShopping({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customSnackBar(context, Toast.error, 'In Updating...');
      },
      child: Column(children: [
        buildCard(Assets.food, 'Food', 'Order Food You Love'),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Expanded(
                  child: buildCard(
                      Assets.grocery, 'Grocery', 'Shop daily life items')),
              const SizedBox(width: 16),
              Expanded(
                  child: buildCard(Assets.desert, 'Deserts', 'Something Sweet'))
            ],
          ),
        )
      ]),
    );
  }

  Card buildCard(String image, String tittle, String content) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(children: [
        Container(
          height: 160,
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        ),
        Positioned(
          left: 12,
          bottom: 12,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(content: tittle, color: Colors.white),
            CustomText(content: content, fontSize: 12, color: Colors.white)
          ]),
        )
      ]),
    );
  }
}
