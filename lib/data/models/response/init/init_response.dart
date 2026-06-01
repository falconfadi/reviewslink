class InitResponse {
  List<ServicesTypes>? servicesTypes;
  String? pathToUploads;
  List<Currencies>? currencies;

  InitResponse({this.servicesTypes, this.pathToUploads, this.currencies});

  InitResponse.fromJson(Map<String, dynamic> json) {
    if (json['services_types'] != null) {
      servicesTypes = <ServicesTypes>[];
      json['services_types'].forEach((v) {
        servicesTypes!.add(new ServicesTypes.fromJson(v));
      });
    }
    pathToUploads = json['path_to_uploads'];
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies!.add(new Currencies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.servicesTypes != null) {
      data['services_types'] = this.servicesTypes!
          .map((v) => v.toJson())
          .toList();
    }
    data['path_to_uploads'] = this.pathToUploads;
    if (this.currencies != null) {
      data['currencies'] = this.currencies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceType {
  int? id;
  String? name;
  String? dataType;
  String? tableName;

  ServiceType({this.id, this.name, this.dataType, this.tableName});

  ServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dataType = json['data_type'];
    tableName = json['table_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['data_type'] = this.dataType;
    data['table_name'] = this.tableName;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceType &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class ServicesTypes {
  int? id;
  String? name;
  String? dataType;
  String? tableName;
  String? creationDate;

  ServicesTypes({
    this.id,
    this.name,
    this.dataType,
    this.tableName,
    this.creationDate,
  });

  ServicesTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dataType = json['data_type'];
    tableName = json['table_name'];
    creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['data_type'] = this.dataType;
    data['table_name'] = this.tableName;
    data['creation_date'] = this.creationDate;
    return data;
  }
}

class Currencies {
  String? id;
  String? name;
  String? symbol;
  String? creationDate;
  String? exchangeRateId;
  String? fromCurrency;
  String? toCurrency;
  String? rate;
  String? exchangeRateCreationDate;
  String? toCurrencyName;
  String? toCurrencySymbol;

  Currencies({
    this.id,
    this.name,
    this.symbol,
    this.creationDate,
    this.exchangeRateId,
    this.fromCurrency,
    this.toCurrency,
    this.rate,
    this.exchangeRateCreationDate,
    this.toCurrencyName,
    this.toCurrencySymbol,
  });

  Currencies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    creationDate = json['creation_date'];
    exchangeRateId = json['exchange_rate_id'];
    fromCurrency = json['from_currency'];
    toCurrency = json['to_currency'];
    rate = json['rate'];
    exchangeRateCreationDate = json['exchange_rate_creation_date'];
    toCurrencyName = json['to_currency_name'];
    toCurrencySymbol = json['to_currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['creation_date'] = this.creationDate;
    data['exchange_rate_id'] = this.exchangeRateId;
    data['from_currency'] = this.fromCurrency;
    data['to_currency'] = this.toCurrency;
    data['rate'] = this.rate;
    data['exchange_rate_creation_date'] = this.exchangeRateCreationDate;
    data['to_currency_name'] = this.toCurrencyName;
    data['to_currency_symbol'] = this.toCurrencySymbol;
    return data;
  }
}
