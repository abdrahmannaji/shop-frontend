import 'dart:convert';

OrderupdataModel orderupdataModelFromJson(String str) =>
    OrderupdataModel.fromJson(json.decode(str));

String orderupdataModelToJson(OrderupdataModel data) =>
    json.encode(data.toJson());

class OrderupdataModel {
  OrderupdataModel({
    this.paymentStatus,
    this.orderStatus,
    this.paymentMethod,
    this.orderAmount,
    this.discountAmount,
    this.discountType,
    this.productId,
    this.shopId,
    this.qty,
    this.price,
    this.tax,
    this.deliveryStatus,
    this.isStockDecreased,
  });

  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;
  int? orderAmount;
  int? discountAmount;
  String? discountType;
  String? productId;
  String? shopId;
  int? qty;
  int? price;
  int? tax;
  String? deliveryStatus;
  String? isStockDecreased;

  factory OrderupdataModel.fromJson(Map<String, dynamic> json) =>
      OrderupdataModel(
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        paymentMethod: json["payment_method"],
        orderAmount: json["order_amount"],
        discountAmount: json["discount_amount"],
        discountType: json["discount_type"],
        productId: json["product_id"],
        shopId: json["shop_id"],
        qty: json["qty"],
        price: json["price"],
        tax: json["tax"],
        deliveryStatus: json["delivery_status"],
        isStockDecreased: json["is_stock_decreased"],
      );

  Map<String, dynamic> toJson() => {
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "payment_method": paymentMethod,
        "order_amount": orderAmount,
        "discount_amount": discountAmount,
        "discount_type": discountType,
        "product_id": productId,
        "shop_id": shopId,
        "qty": qty,
        "price": price,
        "tax": tax,
        "delivery_status": deliveryStatus,
        "is_stock_decreased": isStockDecreased,
      };
}
