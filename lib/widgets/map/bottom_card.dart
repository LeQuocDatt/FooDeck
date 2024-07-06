import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

Widget locationBottomCard(
    BuildContext context, AddressModel addressDetail, int addressIndex) {
  final myLocationsBloc = context.read<MyLocationsBloc>();
  List<Form> tittle = [
    Form('Name of place', addressDetail.name),
    Form('City', addressDetail.city),
    Form('Area', addressDetail.area),
    Form('Address', addressDetail.address),
    Form('Address Instructions', ''),
    Form('Delete Location', '')
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 15),
        child: Container(
          height: 4,
          width: 64,
          decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(800)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: ListTile(
          leading: const Icon(Icons.location_on_outlined),
          title: BlocBuilder<MyLocationsBloc, MyLocationsState>(
            buildWhen: (previous, current) =>
                current is MyLocationsEditAddressState ||
                current is MyLocationsUpdateAddressState,
            builder: (context, state) {
              return myLocationsBloc.edit
                  ? searchTextField(context)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            content: addressDetail.name,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        CustomText(content: addressDetail.address),
                        const SizedBox(height: 5),
                        CustomText(
                            content:
                                '${addressDetail.distance!.toStringAsFixed(2)}km, ${addressDetail.duration!.toStringAsFixed(2)}mins',
                            color: Colors.tealAccent)
                      ],
                    );
            },
          ),
          trailing: IconButton(
              onPressed: () {
                myLocationsBloc.add(MyLocationsEditAddressEvent());
              },
              icon: const Icon(Icons.edit_outlined)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Divider(
          thickness: 8,
          color: Colors.grey[200],
        ),
      ),
      Expanded(
        child: BlocBuilder<MyLocationsBloc, MyLocationsState>(
          buildWhen: (previous, current) => current is MyLocationsSearchState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case MyLocationsSearchState:
                final success = state as MyLocationsSearchState;
                return success.search.isEmpty
                    ? listAddressInfo(
                        tittle, context, addressDetail, addressIndex)
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: success.responses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                CommonUtils.moveCamera(
                                        success.responses[index].location)
                                    .then((value) {
                                  if (context.mounted) {
                                    return showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                        title: const CustomText(
                                            content:
                                                'Do you want to update this location?',
                                            textOverflow: TextOverflow.visible),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                myLocationsBloc.add(
                                                    MyLocationsUpdateAddressEvent(
                                                        context: context,
                                                        addressModel: success
                                                            .responses[index],
                                                        addressId:
                                                            addressDetail,
                                                        index: addressIndex));
                                              },
                                              child: const CustomText(
                                                  content: 'Update',
                                                  color: AppColor.globalPink)),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const CustomText(
                                                  content: 'No'))
                                        ],
                                      ),
                                    );
                                  }
                                });
                              },
                              leading: const Icon(Icons.location_on_outlined),
                              title: CustomText(
                                  content: success.responses[index].name,
                                  fontWeight: FontWeight.bold),
                              subtitle: CustomText(
                                  content: success.responses[index].address));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      );
            }
            return listAddressInfo(
                tittle, context, addressDetail, addressIndex);
          },
        ),
      ),
    ],
  );
}

Widget listAddressInfo(List<Form> tittle, BuildContext context,
    AddressModel addressDetail, int addressIndex) {
  final myLocationsBloc = context.read<MyLocationsBloc>();
  return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: tittle.length,
      itemBuilder: (context, index) {
        return tittle.length - 1 == index
            ? Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextButton(
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const CustomText(
                              content: 'Do you want to delete this location?',
                              textOverflow: TextOverflow.visible),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  myLocationsBloc.add(
                                      MyLocationsRemoveAddressEvent(
                                          addressModel: addressDetail,
                                          context: context,
                                          index: addressIndex));
                                },
                                child: const CustomText(
                                    content: 'Delete', color: Colors.red)),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const CustomText(
                                    content: 'No', color: Colors.blue))
                          ],
                        ),
                      );
                    },
                    child: const CustomText(
                        content: 'Delete Location', color: Colors.red)),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        content: tittle[index].tittle,
                        fontSize: 12,
                        color: Colors.grey),
                    CustomText(
                        content: tittle[index].info,
                        textOverflow: TextOverflow.visible)
                  ],
                ),
              );
      },
      separatorBuilder: (BuildContext context, int index) => const Padding(
          padding: EdgeInsets.symmetric(vertical: 16), child: Divider()));
}

class Form {
  final String tittle;
  final String info;

  Form(this.tittle, this.info);
}
