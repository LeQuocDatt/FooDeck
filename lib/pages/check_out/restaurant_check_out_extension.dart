part of 'restaurant_check_out.dart';

class SelectAddress extends StatelessWidget {
  const SelectAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantCheckOutBloc = context.read<RestaurantCheckOutBloc>();
    return BlocBuilder<RestaurantCheckOutBloc, RestaurantCheckOutState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case RestaurantCheckOutLoadedState:
            final success = state as RestaurantCheckOutLoadedState;
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: success.loading ? 350 : 800,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(24),
                        child: CupertinoSearchTextField(
                            autofocus: true,
                            controller: success.searchController,
                            placeholder: 'Search Location',
                            onChanged: (value) {
                              restaurantCheckOutBloc.add(
                                  RestaurantCheckOutSearchEvent(search: value));
                            })),
                    success.searchController.text.isEmpty
                        ? const SizedBox()
                        : success.responses.isEmpty
                            ? const LinearProgressIndicator(color: Colors.grey)
                            : Divider(
                                thickness: 8,
                                color: Colors.grey[200],
                              ),
                    Flexible(
                      child: success.searchController.text.isEmpty
                          ? const SizedBox()
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: success.responses.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                        onTap: () {
                                          restaurantCheckOutBloc.add(
                                              RestaurantCheckOutMoveCameraEvent(
                                                  index: index));
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500),
                                              () => showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CupertinoAlertDialog(
                                                      title: const CustomText(
                                                          content:
                                                              'Do you want to save this location?',
                                                          textOverflow:
                                                              TextOverflow
                                                                  .visible),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              restaurantCheckOutBloc.add(
                                                                  RestaurantCheckOutEditAddressEvent(
                                                                      index:
                                                                          index));
                                                            },
                                                            child: const CustomText(
                                                                content: 'Save',
                                                                color: AppColor
                                                                    .globalPink)),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                const CustomText(
                                                                    content:
                                                                        'No'))
                                                      ],
                                                    ),
                                                  ));
                                        },
                                        leading: const Icon(
                                            Icons.location_on_outlined),
                                        title: CustomText(
                                            content: success.responses[index]
                                                ['name'],
                                            fontWeight: FontWeight.bold),
                                        subtitle: CustomText(
                                            content: success.responses[index]
                                                ['address'])),
                                    const Divider(),
                                  ],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
        }
        return const SizedBox();
      },
    );
  }
}
