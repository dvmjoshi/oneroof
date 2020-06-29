import 'package:cloud_firestore/cloud_firestore.dart';
class OneRoofRecord{
  final String name;
  final String imageurl;
  final String subheading;
  final String  description;
  final String description2;
  final String  videourl;
  final String  category;
  final String videodes;
  final String facts;
  final DocumentReference reference;


  OneRoofRecord.fromMap(Map<String,dynamic>map,{this.reference})
      :assert(map["name"]!=null),
        assert(map["description"]!=null),
        assert(map["imageurl"]!=null),
        assert(map["description2"]!=null),
        assert(map["videourl"]!=null),
        assert(map["category"]!=null),
        assert(map["subheading"]!=null),
        assert(map["videodes"]!=null),
        assert(map["facts"]!=null),
        name=map["name"],
        imageurl=map["imageurl"],
        description=map["description"],
  description2=map["description2"].replaceAll("\\n", "\n"),
  subheading=map["subheading"].replaceAll("\\n", "\n"),
  category=map["category"].replaceAll("\\n", "\n"),
  videourl=map["videourl"].replaceAll("\\n", "\n"),
  facts=map["facts"].replaceAll("\\n", "\n"),
  videodes=map["videodes"].replaceAll("\\n", "\n");
  OneRoofRecord.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data,reference:snapshot.reference);
  @override
  String toString() =>"VoterRecord<$name:$description:$imageurl:"
      "$description2:$subheading:$category:$videourl:$videodes$facts>";
}