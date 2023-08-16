import 'package:isar/isar.dart';

part 'pokemon.g.dart';

@collection
class Pokemon {
  final Id isarId = Isar.autoIncrement;
  final int id;
  final String name;
  final String url;

  const Pokemon({
    required this.id,
    required this.name,
    required this.url,
  });
}
