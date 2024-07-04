import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

Widget searchAddressBox(BuildContext context) {
  return GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus!.unfocus();
    },
    child: Container(
      height: 800,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(24),
              child: searchTextField(context)),
          Expanded(
            child: BlocBuilder<MyLocationsBloc, MyLocationsState>(
              buildWhen: (previous, current) =>
                  current is MyLocationsSearchState,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case MyLocationsSearchState:
                    final success = state as MyLocationsSearchState;
                    return Column(children: [
                      success.search.isEmpty
                          ? const SizedBox()
                          : success.responses.isEmpty
                              ? const LinearProgressIndicator(
                                  color: Colors.grey)
                              : Divider(
                                  thickness: 8,
                                  color: Colors.grey[200],
                                ),
                      Expanded(
                        child: success.search.isEmpty
                            ? listAddress(address, context)
                            : listNewAddress(success.responses, context),
                      )
                    ]);
                }
                return listAddress(address, context);
              },
            ),
          )
        ],
      ),
    ),
  );
}

Widget listAddress(List<AddressModel> places, BuildContext context) {
  final myLocationsBloc = context.read<MyLocationsBloc>();
  return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: places.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            onTap: () {
              CommonUtils.moveCamera(index, places);
              Future.delayed(const Duration(milliseconds: 1000), () {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const CustomText(
                          content: 'Do you want to chose this location?',
                          textOverflow: TextOverflow.visible),
                      actions: [
                        TextButton(
                            onPressed: () {
                              myLocationsBloc.add(MyLocationsPickAddressEvent(
                                  addressModel: places[index], index: index));
                            },
                            child: const CustomText(
                                content: 'Yes', color: AppColor.globalPink)),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const CustomText(content: 'No'))
                      ],
                    ),
                  );
                }
              });
            },
            leading: const Icon(Icons.location_on_outlined),
            title: CustomText(
                content: places[index].name, fontWeight: FontWeight.bold),
            subtitle: CustomText(
                content: places[index].address,
                textOverflow: TextOverflow.visible));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider());
}

Widget listNewAddress(List<AddressModel> places, BuildContext context) {
  final myLocationsBloc = context.read<MyLocationsBloc>();
  return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: places.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            onTap: () {
              CommonUtils.moveCamera(index, places);
              Future.delayed(const Duration(milliseconds: 1000), () {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const CustomText(
                          content: 'Do you want to save this location?',
                          textOverflow: TextOverflow.visible),
                      actions: [
                        TextButton(
                            onPressed: () {
                              myLocationsBloc.add(MyLocationsSaveAddressEvent(
                                  context: context,
                                  addressModel: places[index]));
                            },
                            child: const CustomText(
                                content: 'Save', color: AppColor.globalPink)),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const CustomText(content: 'No'))
                      ],
                    ),
                  );
                }
              });
            },
            leading: const Icon(Icons.location_on_outlined),
            title: CustomText(
                content: places[index].name, fontWeight: FontWeight.bold),
            subtitle: CustomText(
                content: places[index].address,
                textOverflow: TextOverflow.visible));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider());
}
