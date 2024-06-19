import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    context.read<SearchPageBloc>().add(SearchPageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchPageBloc = context.read<SearchPageBloc>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: AppColor.globalPink,
        title: CupertinoSearchTextField(
          backgroundColor: Colors.white,
          onChanged: (value) {
            searchPageBloc.add(SearchEvent(search: value));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<SearchPageBloc, SearchPageState>(
          buildWhen: (previous, current) => current is SearchState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case SearchState:
                final success = state as SearchState;
                return success.filterItems.isEmpty
                    ? const Center(
                        child: CustomText(
                        content: 'No Restaurant Found',
                        color: Colors.grey,
                      ))
                    : ListView.separated(
                        clipBehavior: Clip.none,
                        itemCount: success.filterItems.length,
                        itemBuilder: (context, index) => BannerItems(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            searchPageBloc.add(
                                SearchPageNavigateToRestaurantPageEvent(
                                    restaurantModel:
                                        success.filterItems[index]));
                          },
                          foodImage: success.filterItems[index].image,
                          deliveryTime:
                              '${success.filterItems[index].deliveryTime} mins',
                          shopName: success.filterItems[index].shopName,
                          shopAddress: success.filterItems[index].address,
                          rateStar: '${success.filterItems[index].rate}',
                          badge: const SizedBox(),
                        ),
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(),
                          );
                        },
                      );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
