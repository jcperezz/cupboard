import 'package:flutter/material.dart';
import 'package:cupboard/constants/Theme.dart';

class CardSmall extends StatelessWidget {
  final String cta;
  final int? count;
  final GestureTapCallback? tap;
  final String title;
  final ImageProvider<Object> image;

  CardSmall(
      {this.title = "Placeholder Title",
      this.cta = "Ver artículos",
      this.count,
      required this.image,
      this.tap = defaultFunc});

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: tap,
          child: Card(
            elevation: 0.4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: _buildImage(),
                ),
                Flexible(
                  flex: 1,
                  child: _buildDetails(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                color: ArgonColors.header,
                fontSize: 20,
              ),
            ),
            if (count != null)
              Text(
                count! > 99 ? "+ 99" : "$count",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: ArgonColors.header,
                  fontSize: 30,
                ),
              ),
            Divider(height: 4, thickness: 0, color: ArgonColors.muted),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  cta,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ArgonColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
        image: DecorationImage(
          image: this.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
