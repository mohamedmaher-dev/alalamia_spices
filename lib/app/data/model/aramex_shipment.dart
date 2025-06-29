class ShipmentData {
  final String? countryCode;
  final String? postalCode;
  final String? stateOrProvinceCode;
  final String? line1;
  final String? city;
  final double? longitude;
  final double? latitude;
  final String? description;
  final String? personName;
  final String? title;
  final String? phoneNumber1;
  final String? cellPhone;
  final String? emailAddress;
  final String? length;
  final String? width;
  final String? height;
  final String? value;
  final String? quantity;
  final String? descriptionOfGoods;
  final String? packageType;

  ShipmentData({
    this.countryCode,
    this.postalCode,
    this.stateOrProvinceCode,
    this.line1,
    this.city,
    this.longitude,
    this.latitude,
    this.description,
    this.personName,
    this.title,
    this.phoneNumber1,
    this.cellPhone,
    this.emailAddress,
    this.length,
    this.width,
    this.height,
    this.value,
    this.quantity,
    this.descriptionOfGoods,
    this.packageType,
  });

  Map<String, dynamic> toJson() {
    return {
      'CountryCode': countryCode,
      // 'PostCode': postalCode,
      'StateOrProvinceCode': stateOrProvinceCode,
      'Line1': line1,
      'City': city,
      'Longitude': longitude,
      'Latitude': latitude,
      'Description': description,
      'PersonName': personName,
      'Title': title,
      'PhoneNumber1': phoneNumber1,
      'CellPhone': cellPhone,
      'EmailAddress': emailAddress,
      'Length': length,
      'Width': width,
      'Height': height,
      'Value': value,
      'Quantity': quantity,
      'DescriptionOfGoods': descriptionOfGoods,
      'PackageType': packageType,
    };
  }
}

class CalculateRate {
  final String? line1;
  final String? city;
  final double? longitude;
  final double? latitude;
  final String? description;
  final String? length;
  final String? width;
  final String? height;
  final String? value;
  final String? numberOfPieces;

  CalculateRate({
    this.line1,
    this.city,
    this.longitude,
    this.latitude,
    this.description,
    this.length,
    this.width,
    this.height,
    this.value,
    this.numberOfPieces,
  });

  Map<String, dynamic> toJson() {
    return {
      'Line1': line1,
      'City': city,
      'Longitude': longitude,
      'Latitude': latitude,
      'Description': description,
      'Length': length,
      'Width': width,
      'Height': height,
      'Value': value,
      'NumberOfPieces': numberOfPieces
    };
  }
}
