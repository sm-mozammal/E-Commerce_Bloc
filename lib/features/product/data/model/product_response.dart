// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<ProductResponse> productResponseFromJson(String str) =>
    List<ProductResponse>.from(
        json.decode(str).map((x) => ProductResponse.fromJson(x)));

String productResponseToJson(List<ProductResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResponse {
  int? id;
  String? code;
  String? name;
  int? unitId;
  String? price;
  String? secondaryPrice;
  Sku? sku;
  String? packSize;
  String? stock;
  Type? type;
  int? categoryId;
  String? notes;
  String? vat;
  Status? status;
  dynamic stdPriceAccounts;
  dynamic vatValueAccounts;
  String? sdvInv;
  String? sdInv;
  String? vatInv;
  int? unitSupply;
  String? unitSupplyQty;
  int? mushok64Show;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic tradeOfferInputQty;
  dynamic tradeOfferQty;
  Sku? unitName;
  String? unitQty;
  CategoryName? categoryName;
  String? stockQty;
  dynamic tradeOfferPrimary;

  ProductResponse({
    this.id,
    this.code,
    this.name,
    this.unitId,
    this.price,
    this.secondaryPrice,
    this.sku,
    this.packSize,
    this.stock,
    this.type,
    this.categoryId,
    this.notes,
    this.vat,
    this.status,
    this.stdPriceAccounts,
    this.vatValueAccounts,
    this.sdvInv,
    this.sdInv,
    this.vatInv,
    this.unitSupply,
    this.unitSupplyQty,
    this.mushok64Show,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.tradeOfferInputQty,
    this.tradeOfferQty,
    this.unitName,
    this.unitQty,
    this.categoryName,
    this.stockQty,
    this.tradeOfferPrimary,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        unitId: json["unit_id"],
        price: json["price"],
        secondaryPrice: json["secondary_price"],
        sku: skuValues.map[json["sku"]],
        packSize: json["pack_size"],
        stock: json["stock"],
        type: typeValues.map[json["type"]]!,
        categoryId: json["category_id"],
        notes: json["notes"],
        vat: json["vat"],
        status: statusValues.map[json["status"]]!,
        stdPriceAccounts: json["std_price_accounts"],
        vatValueAccounts: json["vat_value_accounts"],
        sdvInv: json["sdv_inv"],
        sdInv: json["sd_inv"],
        vatInv: json["vat_inv"],
        unitSupply: json["unit_supply"],
        unitSupplyQty: json["unit_supply_qty"],
        mushok64Show: json["mushok_6_4_show"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        tradeOfferInputQty: json["tradeOfferInputQty"],
        tradeOfferQty: json["tradeOfferQty"],
        unitName: skuValues.map[json["unit_name"]]!,
        unitQty: json["unit_qty"],
        categoryName: categoryNameValues.map[json["category_name"]]!,
        stockQty: json["stockQty"],
        tradeOfferPrimary: json["trade_offer_primary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "unit_id": unitId,
        "price": price,
        "secondary_price": secondaryPrice,
        "sku": skuValues.reverse[sku],
        "pack_size": packSize,
        "stock": stock,
        "type": typeValues.reverse[type],
        "category_id": categoryId,
        "notes": notes,
        "vat": vat,
        "status": statusValues.reverse[status],
        "std_price_accounts": stdPriceAccounts,
        "vat_value_accounts": vatValueAccounts,
        "sdv_inv": sdvInv,
        "sd_inv": sdInv,
        "vat_inv": vatInv,
        "unit_supply": unitSupply,
        "unit_supply_qty": unitSupplyQty,
        "mushok_6_4_show": mushok64Show,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "tradeOfferInputQty": tradeOfferInputQty,
        "tradeOfferQty": tradeOfferQty,
        "unit_name": skuValues.reverse[unitName],
        "unit_qty": unitQty,
        "category_name": categoryNameValues.reverse[categoryName],
        "stockQty": stockQty,
        "trade_offer_primary": tradeOfferPrimary,
      };
}

enum CategoryName {
  GLASS_SPOON_BOTTLE,
  LENTIL,
  MOKHLES_AGRO_FOOD_PRODUCTS,
  MUSTARD_OIL,
  OIL,
  RICE,
  TEST_CATEGORY
}

final categoryNameValues = EnumValues({
  "Glass Spoon & Bottle": CategoryName.GLASS_SPOON_BOTTLE,
  "Lentil": CategoryName.LENTIL,
  "Mokhles Agro Food Products": CategoryName.MOKHLES_AGRO_FOOD_PRODUCTS,
  "Mustard Oil": CategoryName.MUSTARD_OIL,
  "Oil": CategoryName.OIL,
  "Rice": CategoryName.RICE,
  "Test Category": CategoryName.TEST_CATEGORY
});

enum Sku { KG }

final skuValues = EnumValues({"KG": Sku.KG});

enum Status { ACTIVE }

final statusValues = EnumValues({"active": Status.ACTIVE});

enum Type { FINISHED_GOODS }

final typeValues = EnumValues({"finished_goods": Type.FINISHED_GOODS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
