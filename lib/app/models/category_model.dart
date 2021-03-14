class CategoryModel {
  int id;
  String name;
  String titleizedName;

  CategoryModel({this.id, this.name, this.titleizedName});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    titleizedName = json['titleizedName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['titleizedName'] = this.titleizedName;
    return data;
  }
}
