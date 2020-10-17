import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otakunow/domain/episodes/series_episode.dart';
import 'package:otakunow/domain/episodes/series_episodes_bloc.dart';
import 'package:otakunow/domain/episodes/series_episodes_state.dart';
import 'package:otakunow/screens/series_screen.dart';
import 'package:otakunow/widgets/content_scroll.dart';

class EpisodesPreview extends StatelessWidget {
  const EpisodesPreview({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final SeriesScreen widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeriesEpisodesBloc, SeriesEpisodesState>(
      builder: (context, state) {
        if (state is EpisodeStateLoading) {
          return const CircularProgressIndicator();
        }
        if (state is EpisodeStateError) {
          return Text(state.error);
        }
        if (state is EpisodeStateSuccess) {
          return state.episodes.isEmpty
              ? const Text('No episodes found')
              : Expanded(child: _SeriesEpisodes(episodes: state.episodes));
        }
        return const Text('Error - no id specified');
      },
    );
  }
}

class _SeriesEpisodes extends StatelessWidget {
  final List<SeriesEpisode> episodes;

  const _SeriesEpisodes({Key key, this.episodes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentScroll(
      itemCount: episodes.length,
      title: 'Episodes',
      boxHeight: 200.0,
      boxWidth: 250.0,
    );
  }
}