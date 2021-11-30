import 'dart:collection';
import 'package:cupboard/domain/notifiers/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/locale/labels.dart';

import 'package:cupboard/domain/entities/product.dart';
import 'package:cupboard/domain/entities/product_item.dart';

import 'package:cupboard/ui/screens/inventory/widgets/grid_view_no_view_port.dart';
import 'package:cupboard/ui/screens/inventory/widgets/product_painter.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> products;
  final Color? cardColor;
  final String? newProductName;
  final String? cupboardUid;
  final bool isSmallCard;

  final Map<InventoryStatus, Color> _colors = UnmodifiableMapView({
    InventoryStatus.pending: Colors.blue,
    InventoryStatus.avalaible: Colors.green,
    InventoryStatus.close_to_expire: Colors.yellow[900]!,
    InventoryStatus.expired: Colors.red,
  });

  ProductsGrid({
    Key? key,
    required this.products,
    this.cardColor,
    this.newProductName,
    this.cupboardUid,
    this.isSmallCard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsList = products.map((e) => _buildGridTile(context, e)).toList();

    if (this.newProductName == null && productsList.isEmpty) return Container();

    if (this.newProductName != null) {
      productsList.add(_buildGridTile(context,
          Product(name: this.newProductName!, cupboardUid: cupboardUid)));
    }

    return GridViewNoViewPort(
      crossAxisCount: 5,
      childHeight: isSmallCard ? 110 : 130,
      children: productsList,
    );
  }

  Widget _buildGridTile(BuildContext context, Product product) {
    print("${product.runtimeType}");
    if (product.runtimeType.toString().startsWith("ProductItem")) {
      return _buildGridProductItemTile(context, (product as ProductItem));
    } else {
      return _buildGridProductTile(context, product);
    }
  }

  Widget _buildProductCardImage(Product product) {
    return Expanded(
      child: Container(
        //color: Colors.black,
        child: CustomPaint(
          size: Size(40, 40),
          painter: MyPainter(product.name.substring(0, 1)),
          isComplex: true,
          willChange: false,
        ),
      ),
    );
  }

  Widget _buildProductCardTitle(Product product) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Container(
        //color: Colors.brown,
        child: Text(
          "${product.name}",
          //style: ArgonColors.titleCardProducts, // TODO hay que arreglar la letra
          softWrap: true,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildGridProductTile(BuildContext context, Product product) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          ProductItem item = new ProductItem.fromProduct(product);
          Navigator.of(context).pushNamed(
            "/product/$cupboardUid",
            arguments: item,
          );
        },
        child: Card(
          color: _colors[InventoryStatus.pending],
          elevation: 0.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProductCardImage(product),
                    _buildProductCardTitle(product),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridProductItemTile(BuildContext context, ProductItem product) {
    final expiration = Labels.of(context)
        .getMessage("expiration_date_abr", [product.expirationDateShort]);
    final quantity =
        Labels.of(context).getMessage("quantity_abr", [product.quantity]);

    final delete = Labels.of(context).getMessage("delete_label");

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            "/product/$cupboardUid",
            arguments: product,
          );
        },
        child: Card(
          color: _colors[product.productStatus],
          elevation: 0.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildProductCardImage(product),
                        _buildProductCardTitle(product),
                        _buildProductQuantity(quantity),
                        Divider(
                            height: 4, thickness: 0, color: ArgonColors.muted),
                        _buildProductExpiration(expiration),
                      ],
                    ),
                    Align(
                      alignment: Alignment(1.5, -1.3),
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        tooltip: delete,
                        iconSize: 17,
                        onPressed: () {
                          _buildDialog(context, product).show();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildProductExpiration(String expiration) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            expiration,
            style: ArgonColors.titleCardProducts,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Container _buildProductQuantity(String quantity) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Text(
            quantity,
            style: ArgonColors.titleCardProducts,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  AwesomeDialog _buildDialog(BuildContext context, ProductItem product) {
    final notifier = Provider.of<ProductItemNotifier>(context, listen: false);
    final lb = Labels.of(context);

    return AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width * (kIsWeb ? 0.35 : 0.75),
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      //dialogBackgroundColor: Colors.white,
      //title: 'Eliminar Item',
      desc: lb.getMessage("delete_confirm", [product.name]),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        notifier.remove(product, context);
        Navigator.of(context).pushReplacementNamed("/inventory/$cupboardUid");
      },
    );
  }
}
