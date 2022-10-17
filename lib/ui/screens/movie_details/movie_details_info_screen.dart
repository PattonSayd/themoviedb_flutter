// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../app/resources/resources.dart';
import '../movies/widgets/radial_percent_widget.dart';

class MovieDetailsInfoScreen extends StatelessWidget {
  const MovieDetailsInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TopPosterWidget(),
        const _MovieNameWidget(),
        const _ScoreWidget(),
        const SizedBox(height: 10),
        const _SummaryWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TextMovieDetails(
                text: 'Overview',
                size: 20,
                weight: 6,
              ),
              const SizedBox(height: 16),
              const _TextMovieDetails(
                text:
                    'Groot discovers a miniature civilization that believes the seemingly enormous tree toddler is the hero they’ve been waiting for.',
                size: 16,
                weight: 3,
              ),
              const SizedBox(height: 16),
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 16,
                spacing: 80,
                children: const [
                  _PeopleResume(
                      fullName: 'Stefano Solima', jobTitle: 'Director'),
                  _PeopleResume(fullName: 'Jeremih Polac', jobTitle: 'Writer'),
                  _PeopleResume(fullName: 'Jeremih Polac', jobTitle: 'Writer'),
                  _PeopleResume(fullName: 'Jeremih Polac', jobTitle: 'Writer'),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Image(
          image: AssetImage(AppAssets.topLittleGuy),
        ),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Image(
            image: AssetImage(AppAssets.littelGuy),
          ),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Little Guy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: ' (2022)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: RadialPercentWidget(
                    percent: 0.72,
                    fillColor: Color.fromARGB(255, 10, 23, 25),
                    lineColor: Color.fromARGB(255, 37, 203, 103),
                    freeColor: Color.fromARGB(255, 25, 54, 31),
                    lineWidth: 3,
                    child: Text('72'),
                  ),
                ),
                SizedBox(width: 14),
                _TextMovieDetails(
                  text: 'User Score',
                )
              ],
            )),
        Container(
          width: 1,
          height: 22,
          color: Colors.grey,
        ),
        TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                _TextMovieDetails(
                  text: 'Play Trailer',
                ),
              ],
            )),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.3)),
        ),
      ),
      child: const ColoredBox(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 65),
          child: Text(
            'PG 08/10/2022 (US) Animation, Family, Comedy, Science Fiction 5m',
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _PeopleResume extends StatelessWidget {
  final String fullName;
  final String jobTitle;
  const _PeopleResume({
    Key? key,
    required this.fullName,
    required this.jobTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TextMovieDetails(text: fullName),
        _TextMovieDetails(text: jobTitle),
      ],
    );
  }
}

class _TextMovieDetails extends StatelessWidget {
  final String text;
  final double? size;
  final int? weight;
  const _TextMovieDetails({
    Key? key,
    required this.text,
    this.size = 16,
    this.weight = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: FontWeight.values[weight!],
      ),
    );
  }
}
