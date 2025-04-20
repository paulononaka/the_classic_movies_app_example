import 'package:flutter/material.dart';
import 'package:movies/pages/movie_details/components/about_movie_tab_widget.dart';
import 'package:movies/pages/movie_details/components/cast_tab_widget.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class TabContentWidget extends StatelessWidget {
  const TabContentWidget({super.key, required this.movieDetail, required TabController tabController}) : _tabController = tabController;

  final MovieDetailModel movieDetail;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: TabBarView(
        controller: _tabController,
        children: [
          AboutMovieTabWidget(movieDetail: movieDetail),
          CastTabWidget(movieDetail: movieDetail),
        ],
      ),
    );
  }
}
