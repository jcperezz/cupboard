import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  List<ListItem>? items;

  ProductsScreen() {
    items = List<ListItem>.generate(
      1000,
      (i) => i % 6 == 0 ? HeadingItem('Heading $i') : Item('Sender $i'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSafeArea(context);
  }

  Widget _buildSafeArea(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Card(child: _buildList()),
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      itemCount: items!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = items![index];

        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => Container();
}

class Item implements ListItem {
  final String title;

  Item(this.title);

  @override
  Widget buildTitle(BuildContext context) {
    return Card(
      color: Colors.lightGreen[900],
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: Icon(Icons.arrow_forward_ios_outlined)),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => Container();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
