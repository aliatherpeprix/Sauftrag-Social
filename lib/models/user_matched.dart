class UserMatchedModel {
  dynamic id;
  dynamic status;
  User? user;

  UserMatchedModel({this.id, this.status, this.user});

  UserMatchedModel.fromJson(Map<String, dynamic> json) {
    id = json['id']as dynamic;
    status = json['status']as dynamic;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  dynamic id;
  dynamic username;
  dynamic barName;
  dynamic email;
  dynamic phoneNo;
  dynamic countryCode;
  dynamic gender;
  dynamic address;
  dynamic dob;
  dynamic relationShip;
  dynamic role;
  bool? termsConditions;
  bool? dataProtection;
  dynamic profilePicture;
  List<dynamic>? favoriteAlcoholDrinks;
  List<dynamic>? favoriteNightClub;
  List<dynamic>? barKind;
  List<dynamic>? favoritePartyVacation;
  dynamic catalogueImage1;
  dynamic catalogueImage2;
  dynamic catalogueImage3;
  dynamic catalogueImage4;
  dynamic catalogueImage5;

  User(
      {this.id,
        this.username,
        this.barName,
        this.email,
        this.phoneNo,
        this.countryCode,
        this.gender,
        this.address,
        this.dob,
        this.relationShip,
        this.role,
        this.termsConditions,
        this.dataProtection,
        this.profilePicture,
        this.favoriteAlcoholDrinks,
        this.favoriteNightClub,
        this.barKind,
        this.favoritePartyVacation,
        this.catalogueImage1,
        this.catalogueImage2,
        this.catalogueImage3,
        this.catalogueImage4,
        this.catalogueImage5});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id']as dynamic;
    username = json['username']as dynamic;
    barName = json['bar_name']as dynamic;
    email = json['email']as dynamic;
    phoneNo = json['phone_no']as dynamic;
    countryCode = json['country_code']as dynamic;
    gender = json['gender']as dynamic;
    address = json['address']as dynamic;
    dob = json['dob']as dynamic;
    relationShip = json['relation_ship']as dynamic;
    role = json['role']as dynamic;
    termsConditions = json['terms_conditions']as dynamic;
    dataProtection = json['data_protection']as dynamic;
    profilePicture = json['profile_picture']as dynamic;
    if (json['favorite_alcohol_drinks'] != null) {
      favoriteAlcoholDrinks = <dynamic>[];
      json['favorite_alcohol_drinks'].forEach((v) {
        favoriteAlcoholDrinks!.add(v);
      });
    }
    if (json['favorite_night_club'] != null) {
      favoriteNightClub = <dynamic>[];
      json['favorite_night_club'].forEach((v) {
        favoriteNightClub!.add(v);
      });
    }
    if (json['bar_kind'] != null) {
      barKind = <dynamic>[];
      json['bar_kind'].forEach((v) {
        barKind!.add(v);
      });
    }
    if (json['favorite_party_vacation'] != null) {
      favoritePartyVacation = <dynamic>[];
      json['favorite_party_vacation'].forEach((v) {
        favoritePartyVacation!.add(v);
      });
    }
    catalogueImage1 = json['catalogue_image1'];
    catalogueImage2 = json['catalogue_image2'];
    catalogueImage3 = json['catalogue_image3'];
    catalogueImage4 = json['catalogue_image4'];
    catalogueImage5 = json['catalogue_image5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['bar_name'] = this.barName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['country_code'] = this.countryCode;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['relation_ship'] = this.relationShip;
    data['role'] = this.role;
    data['terms_conditions'] = this.termsConditions;
    data['data_protection'] = this.dataProtection;
    data['profile_picture'] = this.profilePicture;
    if (this.favoriteAlcoholDrinks != null) {
      data['favorite_alcohol_drinks'] =
          this.favoriteAlcoholDrinks!.map((v) => v.toJson()).toList();
    }
    if (this.favoriteNightClub != null) {
      data['favorite_night_club'] =
          this.favoriteNightClub!.map((v) => v.toJson()).toList();
    }
    if (this.barKind != null) {
      data['bar_kind'] = this.barKind!.map((v) => v.toJson()).toList();
    }
    if (this.favoritePartyVacation != null) {
      data['favorite_party_vacation'] =
          this.favoritePartyVacation!.map((v) => v.toJson()).toList();
    }
    data['catalogue_image1'] = this.catalogueImage1;
    data['catalogue_image2'] = this.catalogueImage2;
    data['catalogue_image3'] = this.catalogueImage3;
    data['catalogue_image4'] = this.catalogueImage4;
    data['catalogue_image5'] = this.catalogueImage5;
    return data;
  }
}
