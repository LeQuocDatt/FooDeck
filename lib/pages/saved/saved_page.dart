import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

part 'saved_page_extension.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExplorePageBloc, ExplorePageState>(
      buildWhen: (previous, current) => current is ExplorePageLikeState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case ExplorePageLikeState:
            return savedBody(context);
        }
        return savedBody(context);
      },
    );
  }
}
