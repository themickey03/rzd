/// Описание станции
///
/// [region] - Субъект РФ станции
///
/// [id] - API ID станции
///
/// [name] - Название станции
class Destination {

  final String region;
  final int id;
  final String name;

  Destination({
    required this.region,
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'Destination{region: $region, id: $id, name: $name}';

  factory Destination.fromJson({required Map<String, dynamic> raw}) {
    return Destination(
      region: raw["compositeRegion"] ?? "",
      id: int.tryParse((raw["id"] ?? "-1").toString()) ?? -1,
      name: raw["searchName"] ?? "",
    );
  }

}