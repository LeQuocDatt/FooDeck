part of 'restaurant_page.dart';

class RestaurantAppBar extends StatelessWidget {
  const RestaurantAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantPageBloc, RestaurantPageState>(
      buildWhen: (previous, current) =>
          current is RestaurantPageLoadingSuccessState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case RestaurantPageLoadingSuccessState:
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(RestaurantData.restaurantModel.image),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Row(
                            children: optionMenuButton(context),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 24, bottom: 21),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  content:
                                      RestaurantData.restaurantModel.shopName,
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              CustomText(
                                  content:
                                      RestaurantData.restaurantModel.address,
                                  color: Colors.white,
                                  fontSize: 15)
                            ]))
                  ],
                ));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
