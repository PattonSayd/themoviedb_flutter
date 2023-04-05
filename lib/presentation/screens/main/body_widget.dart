import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/factories/screen_factory.dart';
import 'main_viewmodel.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((MainViewModel vm) => vm.selectedTab);
    return Container(
      color: Colors.white,
      child: IndexedStack(
        index: selectedTab,
        children: [
          ScreenFactory.assemblyNews(),
          ScreenFactory.assemblyMoviesPolular(),
          ScreenFactory.assemblyTVShow(),
        ],
      ),
    );
  }
}
