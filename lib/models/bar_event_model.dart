class BarEventModel {
  dynamic id;
  dynamic name;
  dynamic about;
  dynamic lat;
  dynamic long;
  dynamic location;
  dynamic eventDate;
  dynamic startTime;
  dynamic endTime;
  UserId? userId;
  List<Media>? media;

  BarEventModel(
      {this.id,
        this.name,
        this.about,
        this.lat,
        this.long,
        this.location,
        this.eventDate,
        this.startTime,
        this.endTime,
        this.userId,
        this.media});

  BarEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as dynamic;
    name = json['name'] as dynamic;
    about = json['about'] as dynamic;
    lat = json['lat'] as dynamic;
    long = json['long'] as dynamic;
    location = json['location'] as dynamic;
    eventDate = json['event_date'] as dynamic;
    startTime = json['start_time'] as dynamic;
    endTime = json['end_time'] as dynamic;
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['about'] = this.about;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['location'] = this.location;
    data['event_date'] = this.eventDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserId {
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
  dynamic termsConditions;
  dynamic dataProtection;
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

  UserId(
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

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['id'] as dynamic;
    username = json['username']as dynamic;
    barName = json['bar_name']as dynamic;
    email = json['email']as dynamic;
    phoneNo = json['phone_no']as dynamic;
    countryCode = json['country_code'] as dynamic;
    gender = json['gender']as dynamic;
    address = json['address']as dynamic;
    dob = json['dob'] as dynamic;
    relationShip = json['relation_ship'] as dynamic;
    role = json['role'] as dynamic;
    termsConditions = json['terms_conditions'] as dynamic;
    dataProtection = json['data_protection'] as dynamic;
    profilePicture = json['profile_picture'] as dynamic;
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

class Media {
  dynamic id;
  dynamic media;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic eventId;

  Media({this.id, this.media, this.createdAt, this.updatedAt, this.eventId});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id']as dynamic;
    media = json['media']as dynamic;
    createdAt = json['created_at']as dynamic;
    updatedAt = json['updated_at']as dynamic;
    eventId = json['event_id']as dynamic;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['media'] = this.media;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['event_id'] = this.eventId;
    return data;
  }
}
