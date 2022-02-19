class DiscoverModel {
  dynamic id;
  dynamic username;
  dynamic email;
  dynamic phoneNo;
  dynamic countryCode;
  dynamic gender;
  dynamic address;
  dynamic dob;
  dynamic relationShip;
  dynamic role;
  dynamic profilePicture;
  List<dynamic>? favoriteAlcoholDrinks;
  List<dynamic>? favoriteNightClub;
  List<dynamic>? favoritePartyVacation;
  dynamic catalogueImage1;
  dynamic catalogueImage2;
  dynamic catalogueImage3;
  dynamic catalogueImage4;
  dynamic catalogueImage5;
  dynamic distance;

  DiscoverModel(
      {this.id,
        this.username,
        this.email,
        this.phoneNo,
        this.countryCode,
        this.gender,
        this.address,
        this.dob,
        this.relationShip,
        this.role,
        this.profilePicture,
        this.favoriteAlcoholDrinks,
        this.favoriteNightClub,
        this.favoritePartyVacation,
        this.catalogueImage1,
        this.catalogueImage2,
        this.catalogueImage3,
        this.catalogueImage4,
        this.catalogueImage5,
        this.distance});

  DiscoverModel.fromJson(Map<String, dynamic> json) {
    id = json['id']as dynamic;
    username = json['username']as dynamic;
    email = json['email']as dynamic;
    phoneNo = json['phone_no']as dynamic;
    countryCode = json['country_code']as dynamic;
    gender = json['gender']as dynamic;
    address = json['address']as dynamic;
    dob = json['dob']as dynamic;
    relationShip = json['relation_ship']as dynamic;
    role = json['role']as dynamic;
    profilePicture = json['profile_picture']as dynamic;
    favoriteAlcoholDrinks = json['favorite_alcohol_drinks'].cast<int>();
    favoriteNightClub = json['favorite_night_club'].cast<int>();
    favoritePartyVacation = json['favorite_party_vacation'].cast<int>();
    catalogueImage1 = json['catalogue_image1']as dynamic;
    catalogueImage2 = json['catalogue_image2']as dynamic;
    catalogueImage3 = json['catalogue_image3']as dynamic;
    catalogueImage4 = json['catalogue_image4']as dynamic;
    catalogueImage5 = json['catalogue_image5']as dynamic;
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['country_code'] = this.countryCode;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['relation_ship'] = this.relationShip;
    data['role'] = this.role;
    data['profile_picture'] = this.profilePicture;
    data['favorite_alcohol_drinks'] = this.favoriteAlcoholDrinks;
    data['favorite_night_club'] = this.favoriteNightClub;
    data['favorite_party_vacation'] = this.favoritePartyVacation;
    data['catalogue_image1'] = this.catalogueImage1;
    data['catalogue_image2'] = this.catalogueImage2;
    data['catalogue_image3'] = this.catalogueImage3;
    data['catalogue_image4'] = this.catalogueImage4;
    data['catalogue_image5'] = this.catalogueImage5;
    data['distance'] = this.distance;
    return data;
  }
}
