import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    context.read<ExplorePageBloc>().add(ExplorePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
    return BlocBuilder<ExplorePageBloc, ExplorePageState>(
      buildWhen: (previous, current) =>
          current is ExplorePageLoadingSuccessState ||
          current is ExplorePageLikeState,
      builder: (context, state) {
        final restaurant =
            restaurants.where((element) => element.like == true).toList();
        return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomText(
                        content: 'Saved (${restaurant.length})',
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
            body: restaurant.isEmpty
                ? Center(child: Lottie.asset(Assets.shoppingCart))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ListView.separated(
                      itemCount: restaurant.length,
                      scrollDirection: Axis.vertical,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) => BannerItems(
                          foodImage: restaurant[index].image,
                          deliveryTime:
                              '${restaurant[index].deliveryTime} mins',
                          shopName: restaurant[index].shopName,
                          shopAddress: restaurant[index].address,
                          rateStar: '${restaurant[index].rate}',
                          action: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                      title: const CustomText(
                                        content:
                                            'Do you want to remove this item from saved list?',
                                        textOverflow: TextOverflow.visible,
                                      ),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    explorePageBloc.add(
                                                        ExplorePageLikeEvent(
                                                            saveFood:
                                                                restaurant[
                                                                    index]));
                                                    Navigator.pop(context);
                                                  },
                                                  child: const CustomText(
                                                      content: 'Yes',
                                                      color: Colors.red)),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const CustomText(
                                                      content: 'No',
                                                      color: Colors.blue))
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                          },
                          restaurantModel: restaurant[index]),
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(),
                        );
                      },
                    )));
      },
    );
  }
}
