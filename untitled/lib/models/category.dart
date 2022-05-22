class Category{
  String? name;
  String? description;
  int? id;

  categoryMap() {
    var mapping = Map<String,dynamic>();
    mapping['id'] =id;
    mapping['name']=name;
    mapping['description']=description;
    return mapping;
  }
}