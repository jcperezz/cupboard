import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:provider/provider.dart';

import 'package:cupboard/domain/entities/status.dart';

import 'package:cupboard/services/cupboards_service.dart';

//widgets
import 'package:cupboard/widgets/card-small.dart';

class CupboardScreen extends StatelessWidget {
  final String? uid;

  const CupboardScreen({this.uid});

  @override
  Widget build(BuildContext context) {
    return _buildPageBody(context);
  }

  Widget _buildPageBody(BuildContext context) {
    final CupboardsService service =
        Provider.of<CupboardsService>(context, listen: false);

    if (service.selected == null) {
      service.findById(uid!);
    }

    return LoadingOverlay(
      child: _buildSafeArea(context),
      isLoading: service.isLoading,
    );
  }

  Widget _buildSafeArea(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: _buildGrid(context),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 300,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: [
        _buildCard(context, Status.pending()),
        _buildCard(context, Status.expired()),
        _buildCard(context, Status.closeToExpire()),
        _buildCard(context, Status.avalaible()),
      ],
    );
  }

  Widget _buildCard(BuildContext context, Status status) {
    return CardSmall(
        cta: "Ver artículos",
        title: status.title,
        image: AssetImage("assets/img/" + status.img),
        tap: () {
          Navigator.pushNamed(context, "/products");
        });
  }
}
