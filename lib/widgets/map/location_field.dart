import 'package:flutter/cupertino.dart';
import 'package:template/widgets/map/bottom_card.dart';
import 'package:template/widgets/map/mapbox_handler.dart';
import 'package:template/widgets/map/search_model.dart';

class LocationField extends StatefulWidget {
  const LocationField({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  _searchHandler(String value) async {
    // Get response using Mapbox Search API
    List response = await getParsedResponseForQuery(value);
    // Set responses and isDestination in parent
    if (mounted) {
      SearchModel.of(context)?.responsesState = response;
      BottomCard.of(context)?.responsesState = response;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
        controller: widget.textEditingController,
        placeholder: 'Search Location',
        onChanged: _searchHandler);
  }
}
