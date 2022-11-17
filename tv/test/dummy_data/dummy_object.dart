

import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/created_by.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/last_episode_to_air.dart';
import 'package:tv/domain/entities/network.dart';
import 'package:tv/domain/entities/production_country.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/spoken_language.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

final tTvModel = TvModel(
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    firstAirDate: "2022-08-21",
    genreIds: [10765, 18, 10759],
    id: 94997,
    name: "House of the Dragon",
    originCountry: ["US", "B", "C"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 1.0,
    posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    voteAverage: 8.5,
    voteCount: 1816);

final tTv = Tv(
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    firstAirDate: "2022-08-21",
    genreIds: [10765, 18, 10759],
    id: 94997,
    name: "House of the Dragon",
    originCountry: ["US", "B", "C"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 1.0,
    posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    voteAverage: 8.5,
    voteCount: 1816);

final tTvModelList = <TvModel>[tTvModel];
final tTvList = <Tv>[tTv];

final testTvCache = TvTable(
    id: 94997,
    name: "House of the Dragon",
    posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.");

final testTvFromCache = Tv.watchList(
    id: 94997,
    name: "House of the Dragon",
    posterPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.");

final testTvCacheMap = {
  "id": 94997,
  "name": "House of the Dragon",
  "posterPath": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
  "overview":
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm."
};

final expectJsonMap = {
  "results": [
    {
      "backdrop_path": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      "first_air_date": "2022-08-21",
      "genre_ids": [10765, 18, 10759],
      "id": 94997,
      "name": "House of the Dragon",
      "origin_country": ["US", "B", "C"],
      "original_language": "originalLanguage",
      "original_name": "originalName",
      "overview":
          "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
      "popularity": 1.0,
      "poster_path": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      "vote_average": 8.5,
      "vote_count": 1816
    }
  ]
};

final testTvDetail = TvDetail(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    createdBy: [
      CreatedBy(
          id: 9813,
          creditId: "5256c8c219c2956ff604858a",
          name: "David Benioff",
          gender: 2,
          profilePath: "/xvNN5huL0X8yJ7h3IZfGG4O2zBD.jpg"),
      CreatedBy(
          id: 228068,
          creditId: "552e611e9251413fea000901",
          name: "D. B. Weiss",
          gender: 2,
          profilePath: "/2RMejaT793U9KRk2IEbFfteQntE.jpg")
    ],
    episodeRunTime: [60],
    firstAirDate: "2011-04-17",
    genres: [
      Genre(id: 10765, name: "Sci-Fi & Fantasy"),
      Genre(id: 18, name: "Drama"),
      Genre(id: 10759, name: "Action & Adventure"),
      Genre(id: 9648, name: "Mystery")
    ],
    homepage: "http://www.hbo.com/game-of-thrones",
    id: 1399,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "2019-05-19",
    lastEpisodeToAir: LastEpisodeToAir(
        airDate: "2019-05-19",
        episodeNumber: 6,
        id: 1551830,
        name: "The Iron Throne",
        overview:
            "In the aftermath of the devastating attack on King's Landing, Daenerys must face the survivors.",
        productionCode: "806",
        seasonNumber: 8,
        stillPath: "/3x8tJon5jXFa1ziAM93hPKNyW7i.jpg",
        voteAverage: 4.8,
        voteCount: 106),
    name: "Game of Thrones",
    networks: [
      Network(
          name: "HBO",
          id: 49,
          logoPath: "/tuomPhY2UtuPTqqFnKMVHvSb724.png",
          originCountry: "US")
    ],
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 369.594,
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    productionCompanies: [
      Network(
          id: 76043,
          logoPath: "/9RO2vbQ67otPrBLXCaC8UMp3Qat.png",
          name: "Revolution Sun Studios",
          originCountry: "US"),
      Network(
          id: 12525, logoPath: null, name: "Television 360", originCountry: ""),
      Network(
          id: 5820,
          logoPath: null,
          name: "Generator Entertainment",
          originCountry: ""),
      Network(
          id: 12526,
          logoPath: null,
          name: "Bighead Littlehead",
          originCountry: "")
    ],
    productionCountries: [
      ProductionCountry(iso31661: "GB", name: "United Kingdom"),
      ProductionCountry(iso31661: "US", name: "United States of America")
    ],
    seasons: [
      Season(
          airDate: "2010-12-05",
          episodeCount: 64,
          id: 3627,
          name: "Specials",
          overview: "",
          posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
          seasonNumber: 0),
      Season(
          airDate: "2011-04-17",
          episodeCount: 10,
          id: 3624,
          name: "Season 1",
          overview:
              "Trouble is brewing in the Seven Kingdoms of Westeros. For the driven inhabitants of this visionary world, control of Westeros' Iron Throne holds the lure of great power. But in a land where the seasons can last a lifetime, winter is coming...and beyond the Great Wall that protects them, an ancient evil has returned. In Season One, the story centers on three primary areas: the Stark and the Lannister families, whose designs on controlling the throne threaten a tenuous peace; the dragon princess Daenerys, heir to the former dynasty, who waits just over the Narrow Sea with her malevolent brother Viserys; and the Great Wall--a massive barrier of ice where a forgotten danger is stirring.",
          posterPath: "/zwaj4egrhnXOBIit1tyb4Sbt3KP.jpg",
          seasonNumber: 1),
      Season(
          airDate: "2012-04-01",
          episodeCount: 10,
          id: 3625,
          name: "Season 2",
          overview:
              "The cold winds of winter are rising in Westeros...war is coming...and five kings continue their savage quest for control of the all-powerful Iron Throne. With winter fast approaching, the coveted Iron Throne is occupied by the cruel Joffrey, counseled by his conniving mother Cersei and uncle Tyrion. But the Lannister hold on the Throne is under assault on many fronts. Meanwhile, a new leader is rising among the wildings outside the Great Wall, adding new perils for Jon Snow and the order of the Night's Watch.",
          posterPath: "/5tuhCkqPOT20XPwwi9NhFnC1g9R.jpg",
          seasonNumber: 2),
      Season(
          airDate: "2013-03-31",
          episodeCount: 10,
          id: 3626,
          name: "Season 3",
          overview:
              "Duplicity and treachery...nobility and honor...conquest and triumph...and, of course, dragons. In Season 3, family and loyalty are the overarching themes as many critical storylines from the first two seasons come to a brutal head. Meanwhile, the Lannisters maintain their hold on King's Landing, though stirrings in the North threaten to alter the balance of power; Robb Stark, King of the North, faces a major calamity as he tries to build on his victories; a massive army of wildlings led by Mance Rayder march for the Wall; and Daenerys Targaryen--reunited with her dragons--attempts to raise an army in her quest for the Iron Throne.",
          posterPath: "/7d3vRgbmnrRQ39Qmzd66bQyY7Is.jpg",
          seasonNumber: 3),
      Season(
          airDate: "2014-04-06",
          episodeCount: 10,
          id: 3628,
          name: "Season 4",
          overview:
              "The War of the Five Kings is drawing to a close, but new intrigues and plots are in motion, and the surviving factions must contend with enemies not only outside their ranks, but within.",
          posterPath: "/dniQ7zw3mbLJkd1U0gdFEh4b24O.jpg",
          seasonNumber: 4),
      Season(
          airDate: "2015-04-12",
          episodeCount: 10,
          id: 62090,
          name: "Season 5",
          overview:
              "The War of the Five Kings, once thought to be drawing to a close, is instead entering a new and more chaotic phase. Westeros is on the brink of collapse, and many are seizing what they can while the realm implodes, like a corpse making a feast for crows.",
          posterPath: "/527sR9hNDcgVDKNUE3QYra95vP5.jpg",
          seasonNumber: 5),
      Season(
          airDate: "2016-04-24",
          episodeCount: 10,
          id: 71881,
          name: "Season 6",
          overview:
              "Following the shocking developments at the conclusion of season five, survivors from all parts of Westeros and Essos regroup to press forward, inexorably, towards their uncertain individual fates. Familiar faces will forge new alliances to bolster their strategic chances at survival, while new characters will emerge to challenge the balance of power in the east, west, north and south.",
          posterPath: "/zvYrzLMfPIenxoq2jFY4eExbRv8.jpg",
          seasonNumber: 6),
      Season(
          airDate: "2017-07-16",
          episodeCount: 7,
          id: 81266,
          name: "Season 7",
          overview:
              "The long winter is here. And with it comes a convergence of armies and attitudes that have been brewing for years.",
          posterPath: "/3dqzU3F3dZpAripEx9kRnijXbOj.jpg",
          seasonNumber: 7),
      Season(
          airDate: "2019-04-14",
          episodeCount: 6,
          id: 107971,
          name: "Season 8",
          overview:
              "The Great War has come, the Wall has fallen and the Night King's army of the dead marches towards Westeros. The end is here, but who will take the Iron Throne?",
          posterPath: "/39FHkTLnNMjMVXdIDwZN8SxYqD6.jpg",
          seasonNumber: 8)
    ],
    spokenLanguages: [
      SpokenLanguage(englishName: "English", iso6391: "en", name: "English")
    ],
    status: "Ended",
    tagline: "Winter Is Coming",
    type: "Scripted",
    voteAverage: 8.3,
    voteCount: 11504);

final testTvTableCache = TvTable(
  id: 1399,
  name: "Game of Thrones",
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
);
