import 'package:flutter/material.dart';
import 'package:cupboard/constants/Theme.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal({
    this.title = "Placeholder Title",
    this.cta = "",
    this.img = "https://via.placeholder.com/200",
    this.tap = defaultFunc,
  });

  final String cta;
  final String img;
  final Function tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: GestureDetector(
          onTap: () => tap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: _buildImage(),
                ),
                Flexible(
                  flex: 1,
                  child: _buildDetails(),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(color: ArgonColors.header, fontSize: 13)),
          Text(cta,
              style: TextStyle(
                  color: ArgonColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.0),
                bottomLeft: Radius.circular(6.0)),
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            )));
  }
}
