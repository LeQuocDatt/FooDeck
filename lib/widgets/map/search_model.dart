import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class SearchModel extends StatefulWidget {
  const SearchModel({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  State<SearchModel> createState() => _SearchModelState();

  static _SearchModelState? of(BuildContext context) =>
      context.findAncestorStateOfType<_SearchModelState>();
}

class _SearchModelState extends State<SearchModel> {
  Future addCard(index) async {
    Map modifiedResponse =
        await getDirectionsAPIResponse(latLng, responses[index]['location']);
    // Calculate the distance and time
    num distance = modifiedResponse['distance'] / 1000;
    num duration = modifiedResponse['duration'] / 60;
    if (mounted) {
      AsyncFunctions.insertData(
          'restaurants',
          {
            'name': responses[index]['name'],
            'address': responses[index]['address'],
            'area': responses[index]['area'],
            'city': responses[index]['city'],
            'latitude': responses[index]['latitude'],
            'longitude': responses[index]['longitude'],
            'distance': distance,
            'duration': duration,
            'geometry': modifiedResponse['geometry']
          },
          PopUp.allow,
          context,
          'This address was saved');
    }
  }

// Define setters to be used by children widgets
  set responsesState(List response) {
    setState(() {
      responses = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      height: widget.textEditingController.text.isEmpty ? 160 : 400,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(24),
              child: LocationField(
                  textEditingController: widget.textEditingController)),
          widget.textEditingController.text.isEmpty
              ? const SizedBox()
              : Divider(
                  thickness: 8,
                  color: Colors.grey[200],
                ),
          Flexible(
            child: widget.textEditingController.text.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: responses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                moveCamera(index).then(
                                  (value) => Future.delayed(
                                      const Duration(milliseconds: 1500),
                                      () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CupertinoAlertDialog(
                                              title: const CustomText(
                                                  content:
                                                      'Do you want to save this location?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      widget
                                                          .textEditingController
                                                          .clear();
                                                      addCard(index);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const CustomText(
                                                        content: 'Save',
                                                        color: AppColor
                                                            .globalPink)),
                                                TextButton(
                                                    onPressed: () {
                                                      widget
                                                          .textEditingController
                                                          .clear();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const CustomText(
                                                        content: 'No'))
                                              ],
                                            ),
                                          )),
                                );
                              },
                              leading: const Icon(Icons.location_on_outlined),
                              title: CustomText(
                                  content: responses[index]['name'],
                                  fontWeight: FontWeight.bold),
                              subtitle: CustomText(
                                  content: responses[index]['address'])),
                          const Divider(),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
