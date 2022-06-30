import 'package:core/core.dart';
import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-tv';

  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      context.read<WatchlistTvShowsBloc>().add(FetchWatchlistTvShows()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  // ignore: annotate_overrides
  void didPopNext() {
    context.read<WatchlistTvShowsBloc>().add(FetchWatchlistTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:BlocBuilder<WatchlistTvShowsBloc, WatchlistTvShowsState>(
          builder: (context, state) {
            if (state is WatchlistTvShowsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvShowsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistTvShowsError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
