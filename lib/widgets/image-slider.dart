import 'package:cupboard/constants/Theme.dart';
import 'package:flutter/material.dart';

class ImagesSlider extends StatefulWidget {
  final List<String> images;
  final String? title;
  final Function(String)? onTap;

  const ImagesSlider({
    Key? key,
    required this.images,
    this.onTap,
    this.title,
  }) : super(key: key);

  @override
  _ImagesSliderState createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  final ScrollController scrollController = new ScrollController();
  String? _imageSelected;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.images.length == 0) {
      return Container(
        width: double.infinity,
        height: 265,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 265,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                this.widget.title!,
                style: TextStyle(color: ArgonColors.text, fontSize: 16.0),
              ),
            ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              itemCount: widget.images.length,
              itemBuilder: (_, int index) => _ImagePoster(
                widget.images[index],
                onTap: (value) {
                  if (widget.onTap != null) {
                    widget.onTap!(value);
                  }
                  setState(() {
                    _imageSelected = value;
                  });
                },
                isSelect: _imageSelected != null &&
                    _imageSelected == widget.images[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePoster extends StatelessWidget {
  final String image;
  final Function(String)? onTap;
  final bool isSelect;

  const _ImagePoster(this.image, {this.onTap, this.isSelect = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!(this.image);
              }
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  side: isSelect
                      ? BorderSide(color: Colors.blue, width: 3)
                      : BorderSide(color: Colors.grey),
                  borderRadius: ArgonColors.card_border),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: ArgonColors.card_border,
                  image: DecorationImage(
                    image: AssetImage("assets/img/$image"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
