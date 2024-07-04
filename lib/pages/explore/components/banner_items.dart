import 'package:template/source/export.dart';

class BannerItems extends StatelessWidget {
  const BannerItems({
    super.key,
    required this.foodImage,
    this.widthImage,
    required this.deliveryTime,
    required this.shopName,
    required this.shopAddress,
    required this.rateStar,
    this.paddingText,
    this.action,
    this.paddingImage,
    this.onTap,
    this.heartIcon,
    this.badge,
    this.voteStar,
    required this.restaurantModel,
  });

  final EdgeInsets? paddingText;
  final EdgeInsets? paddingImage;
  final String foodImage;
  final double? widthImage;
  final String deliveryTime;
  final String shopName;
  final String shopAddress;
  final String rateStar;
  final VoidCallback? action;
  final VoidCallback? onTap;
  final Widget? heartIcon;
  final Widget? badge;
  final Widget? voteStar;
  final RestaurantModel restaurantModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingImage ?? EdgeInsets.zero,
      child: SizedBox(
        height: 300,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Stack(alignment: Alignment.topRight, children: [
              GestureDetector(
                onTap: onTap,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(
                            foodImage,
                          ),
                          fit: BoxFit.cover,
                        )),
                    width: widthImage ?? MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              badge ??
                  Positioned(
                      left: 12,
                      bottom: 12,
                      child: Card(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: CustomText(
                                  content: deliveryTime,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)))),
              heartIcon ??
                  GestureDetector(
                      onTap: action,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12, top: 12),
                        child: SizedBox(
                            width: 24,
                            height: 24,
                            child:
                                BlocConsumer<ExplorePageBloc, ExplorePageState>(
                              buildWhen: (previous, current) =>
                                  current is ExplorePageLoadingSuccessState ||
                                  current is ExplorePageLikeState,
                              listenWhen: (previous, current) =>
                                  current is ExplorePageLikeState,
                              listener: (BuildContext context,
                                  ExplorePageState state) {
                                if (state is ExplorePageLikeState) {
                                  CommonUtils.toggleLike(state, context);
                                }
                              },
                              builder: (context, state) {
                                return restaurantModel.like
                                    ? const Icon(Icons.favorite,
                                        color: AppColor.globalPink)
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      );
                              },
                            )),
                      ))
            ]),
          ),
          Padding(
            padding: paddingText ?? const EdgeInsets.only(top: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            content: shopName, fontWeight: FontWeight.bold),
                        CustomText(
                            content: shopAddress,
                            fontSize: 15,
                            color: Colors.grey)
                      ]),
                  voteStar ??
                      TextButton.icon(
                          style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                          onPressed: null,
                          label: CustomText(
                              content: rateStar,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                          icon: Image.asset(
                            Assets.star,
                            fit: BoxFit.cover,
                          ))
                ]),
          )
        ]),
      ),
    );
  }
}
