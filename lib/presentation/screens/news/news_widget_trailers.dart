import 'package:flutter/material.dart';
import 'package:the_movie/app/resources/resources.dart';

class NewsWidgetTrailers extends StatefulWidget {
  const NewsWidgetTrailers({Key? key}) : super(key: key);

  @override
  State<NewsWidgetTrailers> createState() => _NewsWidgetTrailersState();
}

class _NewsWidgetTrailersState extends State<NewsWidgetTrailers> {
  final _catrgory = 'streaming';
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          colorFilter:
              ColorFilter.mode(Colors.blueGrey.shade700, BlendMode.modulate),
          image: const AssetImage(AppAssets.trailerBackground),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lastes Trailer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                DropdownButton<String>(
                  value: _catrgory,
                  dropdownColor: Colors.blueGrey.shade900,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.white,
                  onChanged: (catrgory) {},
                  items: const [
                    DropdownMenuItem(
                        value: 'streaming', child: Text('Streaming')),
                    DropdownMenuItem(value: 'tv', child: Text('On TV')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 306,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemExtent: constraints.maxWidth * 0.9,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: const [
                                      Image(
                                        image: AssetImage(
                                            AppAssets.trailerPreview),
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 20,
                                                spreadRadius: -20),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.white,
                                          size: 80,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 15,
                                right: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Elite',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 10),
                            child: Text(
                              'Elite Season 4 | Trailter | Netflix',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
