import 'package:cupboard/domain/entities/cupboard.dart';
import 'package:flutter/material.dart';
import 'package:cupboard/constants/Theme.dart';
import 'package:google_fonts/google_fonts.dart';

class CupboardCard extends StatelessWidget {
  final Cupboard cupboard;
  final GestureTapCallback? tap;

  CupboardCard({
    required this.cupboard,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: tap,
          child: Card(
            //color: Colors.purple,
            elevation: 0.4,
            shape: _buildCardShape(),
            child: Stack(
              children: [
                Column(
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
                // Align(
                //   alignment: Alignment.topRight,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       children: [
                //         Text(
                //           "${cupboard.name}",
                //           style: TextStyle(
                //               color: ArgonColors.white,
                //               fontSize: 20,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         Text(
                //           "10 items",
                //           style: TextStyle(
                //               color: Colors.white, backgroundColor: Colors.red),
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder _buildCardShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)));
  }

  Widget _buildDetails() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${cupboard.name} [ ${cupboard.count} ítems ]",
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Divider(height: 4, thickness: 0, color: ArgonColors.muted),
            _buildCollaboratorsDetail()
          ],
        ),
      ),
    );
  }

  Widget _buildCollaboratorsDetail() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Row(
          children: [
            IconButton(
              iconSize: 35,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              onPressed: () {},
              icon: CircleAvatar(
                backgroundColor: ArgonColors.initial,
                backgroundImage: AssetImage("assets/img/profile.jpg"),
              ),
            ),
            IconButton(
              iconSize: 35,
              tooltip: "Share with...",
              padding: const EdgeInsets.symmetric(horizontal: 4),
              onPressed: () {},
              icon: CircleAvatar(
                backgroundColor: ArgonColors.initial,
                child: Icon(Icons.add, color: ArgonColors.white),
              ),
            ),
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
          image: AssetImage("assets/img/${cupboard.image}"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
