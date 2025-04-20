import 'package:flutter/material.dart';
import 'package:movies/l10n/s.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key, required TabController tabController}) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: S.of(context)!.movie_details_tab_about),
          Tab(text: S.of(context)!.movie_details_tab_produced_by),
        ],
      ),
    );
  }
}
