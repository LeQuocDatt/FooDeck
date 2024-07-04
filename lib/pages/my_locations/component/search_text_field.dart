import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

Widget searchTextField(BuildContext context) {
  final myLocationsBloc = context.read<MyLocationsBloc>();
  return CupertinoSearchTextField(
      autofocus: true,
      placeholder: 'Search Location',
      onChanged: (value) {
        myLocationsBloc
            .add(MyLocationsSearchEvent(search: value));
      });
}