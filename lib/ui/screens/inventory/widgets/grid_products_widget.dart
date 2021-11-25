import 'dart:collection';

import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/ui/screens/inventory/widgets/grid_view_no_view_port.dart';
import 'package:cupboard/ui/screens/inventory/widgets/product_painter.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final List<ProductItem> products;
  final Color? cardColor;
  final String? newProductName;
  final String? cupboardUid;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsList = products.map((e) => _buildGridTile(context, e)).toList();

    if (this.newProductName == null && productsList.isEmpty) return Container();

    if (this.newProductName != null) {
      productsList.add(_buildGridTile(context,
          ProductItem(name: this.newProductName!, cupboardUid: cupboardUid)));
    }

    return GridViewNoViewPort(
      crossAxisCount: 5,
      childHeight: 130,
      children: productsList,
    );
  }

  Widget _buildGridTile(BuildContext context, ProductItem product) {
    final expirationAbr =
        Labels.of(context).getMessage("expiration_abreviation");

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            "/product/${product.cupboardUid}",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
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
                    ),
                    Expanded(
                      child: Container(
                        //color: Colors.black,
                        child: CustomPaint(
                          size: Size(40, 40),
                          painter: MyPainter(product.name.substring(0, 1)),
                          isComplex: true,
                          willChange: false,
                        ),
                      ),
                    ),
                    Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                    if (product.quantity != null)
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Und. x ${product.quantity}",
                              //style: ArgonColors.titleCardProducts, // TODO hay que arreglar la letra
                              softWrap: true,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    if (product.expirationDateShort != null)
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            //color: Colors.brown,
                            child: Text(
                              "$expirationAbr ${product.expirationDateShort}",
                              //style: ArgonColors.titleCardProducts, // TODO hay que arreglar la letra
                              softWrap: true,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
}
