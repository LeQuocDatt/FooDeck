part of 'saved_page.dart';

Widget savedBody(BuildContext context) {
  final explorePageBloc = context.read<ExplorePageBloc>();
  return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CustomText(
                  content: 'Saved (${SavedListData.saveFood.length})',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      body: SavedListData.saveFood.isEmpty
          ? Center(child: Lottie.asset(Assets.shoppingCart))
          : Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 144),
              child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: SavedListData.saveFood.length,
                      scrollDirection: Axis.vertical,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: BannerItems(
                              foodImage: SavedListData.saveFood[index].image,
                              deliveryTime:
                                  '${SavedListData.saveFood[index].deliveryTime} mins',
                              shopName: SavedListData.saveFood[index].shopName,
                              shopAddress:
                                  SavedListData.saveFood[index].address,
                              rateStar: '${SavedListData.saveFood[index].rate}',
                              action: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                          title: const CustomText(
                                              content:
                                                  'Do you want to remove this item from saved list?'),
                                          actions: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        explorePageBloc.add(
                                                            ExplorePageLikeEvent(
                                                                saveFood:
                                                                    SavedListData
                                                                            .saveFood[
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
                              restaurantModel:
                                  SavedListData.saveFood[index]))))));
}
