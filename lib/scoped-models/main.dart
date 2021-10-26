import 'package:scoped_model/scoped_model.dart';


import './connected_products.dart';


//with keyword aka use krnwa yam clz akak thwth clz akak ekka merge krnna,anam inherit krnna
class MainModel extends Model with ConnectedProductsModel,UserModel, ProductsModel,UtilityModel {}
