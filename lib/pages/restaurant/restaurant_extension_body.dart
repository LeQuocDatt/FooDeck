part of 'restaurant_page.dart';

class RestaurantBody extends StatelessWidget {
  const RestaurantBody({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantPageBloc = context.read<RestaurantPageBloc>();
    return BlocBuilder<RestaurantPageBloc, RestaurantPageState>(
      buildWhen: (previous, current) =>
          current is RestaurantPageLoadingSuccessState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case RestaurantPageLoadingSuccessState:
            return TabBarView(
                children: FoodCategory.values.map((category) {
              List<FoodItems> categoryMenu = CommonUtils.sortFood(
                  category, RestaurantData.restaurantModel.foodItems);
              return ListView.separated(
                  itemCount: categoryMenu.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final food = categoryMenu[index];
                    return GestureDetector(
                      onTap: () {
                        restaurantPageBloc.add(
                            RestaurantPageNavigateToAddonEvent(
                                foodItems: food));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
                            title: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                          image: AssetImage(food.picture),
                                          fit: BoxFit.cover))),
                              const SizedBox(width: 20),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(content: food.nameFood),
                                    CustomText(
                                        content: food.detail,
                                        fontSize: 15,
                                        color: Colors.grey),
                                    const SizedBox(height: 20),
                                    CustomText(
                                        content: '\$${food.price}',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)
                                  ]),
                            ],
                          ),
                        )),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(color: Colors.grey[300]),
                    );
                  });
            }).toList());
        }
        return const SizedBox.shrink();
      },
    );
  }
}
