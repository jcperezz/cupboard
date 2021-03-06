import 'package:cupboard/locale/labels.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/constants/images.dart';

import 'package:cupboard/ui/widgets/localization_text.dart';

import 'package:cupboard/domain/entities/cupboard.dart';
import 'package:cupboard/domain/entities/product_item.dart';

class CardCupboard extends StatelessWidget {
  final Cupboard cupboard;
  final GestureTapCallback? onTap;
  final VoidCallback? editEvent;

  const CardCupboard(
      {Key? key, required this.cupboard, this.onTap, this.editEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(children: [
          _buildCard(cupboard, context),
          _builDeteleButon(context),
        ]),
      ),
    );
  }

  Align _builDeteleButon(BuildContext context) {
    return Align(
      alignment: Alignment(1, -1),
      child: IconButton(
        icon: Icon(
          Icons.settings,
          color: ArgonColors.initial,
        ),
        tooltip: Labels.of(context).getMessage("edit_cupboard"),
        iconSize: 30,
        onPressed: editEvent,
      ),
    );
  }

  Gradient _buildGradient(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: colors,
    );
  }

  Widget _buildCard(Cupboard cupboard, BuildContext context) {
    final colors = MyImages.cupboard_images[cupboard.image];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        gradient: _buildGradient(colors!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(cupboard),
                    _buildTextStatusCount(InventoryStatus.all,
                        "count_inventory_all", cupboard.totalItems),
                    _buildTextStatusCount(
                        InventoryStatus.close_to_expire,
                        "count_inventory_close_to_expire",
                        cupboard.totalCloseToExpire),
                    _buildTextStatusCount(InventoryStatus.expired,
                        "count_inventory_expired", cupboard.totalExpired),
                    Expanded(child: const SizedBox.shrink()),
                    _buildCollaboratorsDetail(),
                  ],
                ),
              ),
            ),
            Flexible(
              child: _buildImage(cupboard),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(Cupboard cupboard) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.topRight,
            image: AssetImage("assets/img/${cupboard.image}"),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(Cupboard cupboard) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "${cupboard.name}",
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ],
    );
  }

  Widget _buildTextStatusCount(
      InventoryStatus status, String label, int total) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.info, color: ArgonColors.color_by_status[status]),
          SizedBox(width: 5),
          LocaleText.white(label, args: [total]),
        ],
      ),
    );
  }

  Widget _buildCollaboratorsDetail() {
    return Container(
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
}
