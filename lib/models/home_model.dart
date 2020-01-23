class HomeModel {
  List<Data> data;

  HomeModel({this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String section;
  String sectionTitle;
  List<Items> items;

  Data({this.section, this.sectionTitle, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    sectionTitle = json['section_title'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section'] = this.section;
    data['section_title'] = this.sectionTitle;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String articleTitle;
  String articleImage;
  String link;
  String productName;
  String productImage;

  Items(
      {this.articleTitle,
      this.articleImage,
      this.link,
      this.productName,
      this.productImage});

  Items.fromJson(Map<String, dynamic> json) {
    articleTitle = json['article_title'];
    articleImage = json['article_image'];
    link = json['link'];
    productName = json['product_name'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article_title'] = this.articleTitle;
    data['article_image'] = this.articleImage;
    data['link'] = this.link;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    return data;
  }
}