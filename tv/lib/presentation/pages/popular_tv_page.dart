import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularTvShowsBloc>().add(FetchPopularTvShows()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
          builder: (context, state) {
            if (state is PopularTvShowsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvShowsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTvShowsError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
