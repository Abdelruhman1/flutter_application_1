import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Inner%20Screens/Product%20Details.dart';
import 'package:flutter_application_1/Models/orders_model.dart';
import 'package:flutter_application_1/Widget/text_widget.dart';
import 'package:flutter_application_1/provider/products_provider.dart';
import 'package:flutter_application_1/servecis/global%20method.dart';
import 'package:flutter_application_1/servecis/utils.dart';

import 'package:provider/provider.dart';



class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    // var orderDate = ordersModel.orderDate.toDate();
    // orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrderModel>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(ordersModel.productId);
    return ListTile(
      subtitle:
      Text('Paid: \$${double.parse(ordersModel.price).toStringAsFixed(2)}'),
      onTap: () {
  navigateTo(context, Product_Details());
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: getCurrProduct.imageUrl,
        boxFit: BoxFit.fill,
      ),
      title: Textwidget(
          text: '${getCurrProduct.title}  x${ordersModel.quantity}',
          color: color,
          textsize:  18),
      // trailing: Textwidget(text: orderDateToShow, color: color, textsize:  18),
    );
  }
}
