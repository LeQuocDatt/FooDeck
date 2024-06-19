import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:template/source/export.dart';

class BottomCard extends StatefulWidget {
  const BottomCard(
      {super.key,
      required this.name,
      required this.address,
      required this.distance,
      required this.duration,
      required this.area,
      required this.city,
      required this.textEditingController});

  final String name;
  final String address;
  final String area;
  final String city;
  final String distance;
  final String duration;
  final TextEditingController textEditingController;

  @override
  State<BottomCard> createState() => _BottomCardState();

  static _BottomCardState? of(BuildContext context) =>
      context.findAncestorStateOfType<_BottomCardState>();
}

class _BottomCardState extends State<BottomCard> {
  bool edit = false;
  Artboard? deleteButton;
  SMITrigger? yesClick;
  SMITrigger? noClick;

  @override
  void initState() {
    rootBundle.load('assets/rives/delete.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artBoard, 'State Machine 1');
        if (controller != null) {
          artBoard.addController(controller);
          yesClick = controller.findSMI('yes click');
          noClick = controller.findSMI('no click');
        }
        setState(() => deleteButton = artBoard);
      },
    );
    super.initState();
  }

  Future addCard(index) async {
    Map modifiedResponse =
        await getDirectionsAPIResponse(latLng, responses[index]['location']);
    // Calculate the distance and time
    num distance = modifiedResponse['distance'] / 1000;
    num duration = modifiedResponse['duration'] / 60;
    if (mounted) {
      AsyncFunctions.updateData(
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
          'Address updated');
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
    List<Form> tittle = [
      Form('Name of place', widget.name),
      Form('City', widget.city),
      Form('Area', widget.area),
      Form('Address', widget.address),
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
            title: edit
                ? LocationField(
                    textEditingController: widget.textEditingController)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          content: widget.name,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      CustomText(content: widget.address),
                      const SizedBox(height: 5),
                      CustomText(
                          content:
                              '${widget.distance}km, ${widget.duration}mins',
                          color: Colors.tealAccent)
                    ],
                  ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    edit = !edit;
                  });
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
        Flexible(
          child: widget.textEditingController.text.isEmpty
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: tittle.length,
                  itemBuilder: (context, index) {
                    return tittle.length - 1 == index
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          title: deleteButton == null
                                              ? const SizedBox()
                                              : SizedBox(
                                                  height: 300,
                                                  width: 300,
                                                  child: Rive(
                                                    artboard: deleteButton!,
                                                    fit: BoxFit.cover,
                                                  )),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    yesClick!.value = true;
                                                  });
                                                  AsyncFunctions.deleteData(
                                                      'restaurants',
                                                      {
                                                        'name': widget.name,
                                                        'address':
                                                            widget.address,
                                                        'area': widget.area,
                                                        'city': widget.city
                                                      },
                                                      PopUp.allow,
                                                      context,
                                                      'Address was deleted');
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 2000),
                                                      () => Navigator.pop(
                                                          context));
                                                },
                                                child: const CustomText(
                                                    content: 'Delete',
                                                    color: Colors.red)),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    noClick!.value = true;
                                                  });
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 850),
                                                      () => Navigator.pop(
                                                          context));
                                                },
                                                child: const CustomText(
                                                    content: 'No',
                                                    color: Colors.blue))
                                          ],
                                        ),
                                      );
                                    },
                                    child: const CustomText(
                                        content: 'Delete Location',
                                        color: Colors.red)),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        content: tittle[index].tittle,
                                        fontSize: 12,
                                        color: Colors.grey),
                                    CustomText(content: tittle[index].info)
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Divider(),
                              )
                            ],
                          );
                  })
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: responses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              moveCamera(index).then((value) =>
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      title: const Text(
                                          'Do you want to save this location?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              addCard(index);
                                              Navigator.pop(context);
                                            },
                                            child: const CustomText(
                                                content: 'Save',
                                                color: AppColor.globalPink)),
                                        TextButton(
                                            onPressed: () {
                                              widget.textEditingController
                                                  .clear();
                                              Navigator.pop(context);
                                            },
                                            child:
                                                const CustomText(content: 'No'))
                                      ],
                                    ),
                                  ));
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
    );
  }
}

class Form {
  final String tittle;
  final String info;

  Form(this.tittle, this.info);
}
