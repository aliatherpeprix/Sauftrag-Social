class CatalogImages {
  dynamic catalogueImage1;
  dynamic catalogueImage2;
  dynamic catalogueImage3;
  dynamic catalogueImage4;
  dynamic catalogueImage5;

  CatalogImages(
      {this.catalogueImage1,
        this.catalogueImage2,
        this.catalogueImage3,
        this.catalogueImage4,
        this.catalogueImage5});

  CatalogImages.fromJson(Map<String, dynamic> json) {
    catalogueImage1 = json['catalogue_image1']as dynamic;
    catalogueImage2 = json['catalogue_image2']as dynamic;
    catalogueImage3 = json['catalogue_image3']as dynamic;
    catalogueImage4 = json['catalogue_image4']as dynamic;
    catalogueImage5 = json['catalogue_image5']as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catalogue_image1'] = this.catalogueImage1;
    data['catalogue_image2'] = this.catalogueImage2;
    data['catalogue_image3'] = this.catalogueImage3;
    data['catalogue_image4'] = this.catalogueImage4;
    data['catalogue_image5'] = this.catalogueImage5;
    return data;
  }
}
