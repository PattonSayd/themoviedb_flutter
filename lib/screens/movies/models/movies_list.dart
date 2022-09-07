import 'package:the_movie/resources/resources.dart';

class Movies {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movies({
    required this.id,
    required this.imageName,
    required this.title,
    required this.time,
    required this.description,
  });
}

abstract class MoviesList {
  static final movies = [
    Movies(
      id: 1,
      imageName: AppImages.walkingdead,
      title: 'The Walking Dead',
      time: 'Oct 31, 2010',
      description:
          'Sheriff\'s deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.',
    ),
    Movies(
      id: 2,
      imageName: AppImages.theBoys,
      title: 'The Boys',
      time: 'Jul 25, 2019',
      description:
          'A group of vigilantes known informally as “The Boys” set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.',
    ),
    Movies(
      id: 3,
      imageName: AppImages.oficceInvasion,
      title: 'Office Invasion',
      time: 'Aug 10, 2022',
      description:
          'Three friends come together to defend their valuable mining company from…aliens?! What could possibly go wrong?',
    ),
    Movies(
      id: 4,
      imageName: AppImages.littelGuy,
      title: 'The Little Guy',
      time: 'Aug 10, 2022',
      description:
          'Groot discovers a miniature civilization that believes the seemingly enormous tree toddler is the hero they’ve been waiting for.',
    ),
    Movies(
      id: 5,
      imageName: AppImages.odetoJoy,
      title: 'Ode to Joy',
      time: 'Apr 18, 2016',
      description:
          'Can five single, independent career women who live in the Ode to Joy apartment building find fulfillment on their own terms? An Di is a successful business woman who has returned to China after studying in New York to find her younger brother.',
    ),
    Movies(
      id: 6,
      imageName: AppImages.codemane,
      title: 'Code Name: Emperor',
      time: 'Mar 18, 2022',
      description:
          'Follows Juan, an agent working for the intelligence services, who also reports to a parallel unit involved in illegal activities.',
    ),
    Movies(
      id: 7,
      imageName: AppImages.fireOne,
      title: 'Catch the Fair One',
      time: 'Feb 11, 2022',
      description:
          'A Native American boxer embarks on the fight of her life when she goes in search of her missing sister.',
    ),
    Movies(
      id: 8,
      imageName: AppImages.samaritan,
      title: 'Samaritan',
      time: 'Aug 25, 2022',
      description:
          'Thirteen year old Sam Cleary suspects that his mysteriously reclusive neighbor Mr. Smith is actually the legendary vigilante Samaritan, who was reported dead 20 years ago.',
    ),
    Movies(
      id: 9,
      imageName: AppImages.firststeps,
      title: 'Groot\'s First Steps',
      time: 'Aug 10, 2022',
      description:
          'Following the events of “Guardians of the Galaxy Vol. 1,” Baby Groot is finally ready to try taking his first steps out of his pot—only to learn you have to walk before you can run.',
    ),
    Movies(
      id: 10,
      imageName: AppImages.luck,
      title: 'Luck',
      time: 'Aug 05, 2022',
      description:
          'Suddenly finding herself in the never-before-seen Land of Luck, the unluckiest person in the world must unite with the magical creatures there to turn her luck around.',
    )
  ];
}
