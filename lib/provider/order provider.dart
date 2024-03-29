import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Constants/firebase%20constants.dart';
import 'package:flutter_application_1/Models/orders_model.dart';


class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }
  void clearLocalorders() {
    _orders.clear();
    notifyListeners();
  }
  Future<void> fetchOrders() async {
    User?user=authInstance.currentUser;
    await FirebaseFirestore.instance
        .collection('orders').where('userId',isEqualTo: user!.uid,)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders = [];
      // _orders.clear();
      ordersSnapshot.docs.forEach((element) {
        _orders.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            userId: element.get('userId'),
            productId: element.get('productId'),
            userName: element.get('userName'),
            price: element.get('price').toString(),
            imageUrl: element.get('imageUrl'),
            quantity: element.get('quantity').toString(),
            // orderDate: element.get('orderDate'),
          ),
        );
      });
    });
    notifyListeners();
  }
}
