import 'package:masterflutter/models/cart_model.dart';
import 'package:masterflutter/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore{
  late CatalogModels catalog;
  late CartModel cart;

  MyStore() {
    catalog = CatalogModels();
    cart = CartModel();
    cart.catalog = catalog;
  }

}