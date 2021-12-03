import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/ui/widgets/localization_text.dart';
import 'package:flutter/material.dart';

class ImagesSlider extends StatefulWidget {
  final Map<String, List<Color>> images;
  final String? selected;
  final String? title;
  final Color? titleColor;
  final Function(String)? onTap;

  const ImagesSlider({
    Key? key,
    required this.images,
    this.onTap,
    this.title,
    this.selected,
    this.titleColor,
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
    _imageSelected = widget.selected;
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
              child: LocaleText.color(
                this.widget.title!,
                color: widget.titleColor ?? Colors.white,
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
              itemBuilder: (_, int index) {
                String image = widget.images.keys.toList()[index];
                List<Color> colors = widget.images[image]!;

                return _ImagePoster(
                  image,
                  colors,
                  onTap: (value) {
                    if (widget.onTap != null) {
                      widget.onTap!(value);
                    }
                    setState(() {
                      _imageSelected = value;
                    });
                  },
                  isSelect: _imageSelected != null && _imageSelected == image,
                );
              },
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
  final List<Color> colors;

  const _ImagePoster(this.image, this.colors,
      {this.onTap, this.isSelect = false});

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
              shape: _buildBorder(),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: _buildDecoration(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Decoration _buildDecoration() {
    return BoxDecoration(
      gradient: _buildGradient(colors),
      borderRadius: ArgonColors.card_border,
      image: DecorationImage(
        image: AssetImage("assets/img/$image"),
        fit: BoxFit.cover,
      ),
    );
  }

  ShapeBorder _buildBorder() {
    return RoundedRectangleBorder(
        side: isSelect
            ? BorderSide(color: Colors.blue, width: 3)
            : BorderSide(color: Colors.grey),
        borderRadius: ArgonColors.card_border);
  }

  Gradient _buildGradient(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: colors,
    );
  }
}
