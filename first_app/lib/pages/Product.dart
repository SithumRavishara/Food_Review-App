import 'package:flutter/material.dart';

import 'dart:async';

import 'package:map_view/map_view.dart';

import '../widgets/ui_elements/title_default.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  void _showMap() {
    final List<Marker> markers = <Marker>[
      Marker('position', 'Position', product.location.latitude,
          product.location.longtitude)
    ];
    final cameraPosition = CameraPosition(
        Location(product.location.latitude, product.location.longtitude), 14.0);
    final mapView = MapView();
    mapView.show(
      MapOptions(
        initialCameraPosition: cameraPosition,
        mapViewType: MapViewType.normal,
        title: 'Product location'
      ),
      toolbarActions: [ToolbarAction('Close',1),]
    );
    mapView.onToolbarAction.listen((int id) {
      if(id==1){
        mapView.dismiss();
      }
    });
    mapView.onMapReady.listen((_){
      mapView.setMarkers(markers);
    });
  }

  Widget _buildAddressPriceRow(String address, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: _showMap,
          child: Text(
            address,
            style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '\$' + price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('print backed');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FadeInImage(
              image: NetworkImage(product.image),
              height: 300.0,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/sabra.jpg'),
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(product.title)),
            _buildAddressPriceRow(product.location.address, product.price),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
