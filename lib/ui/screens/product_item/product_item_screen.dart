import 'dart:ui';
import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/domain/notifiers/category_notifier.dart';
import 'package:cupboard/domain/notifiers/product_item_notifier.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/constants/validators.dart';

import 'package:cupboard/locale/labels.dart';

import 'package:cupboard/widgets/button.dart';
import 'package:cupboard/widgets/form-input.dart';

class ProductItemScreen extends StatefulWidget {
  final ProductItem product;
  final String cupboardUid;

  ProductItemScreen(
      {Key? key, required this.product, required this.cupboardUid})
      : super(key: key);

  @override
  _ProductItemScreenState createState() => _ProductItemScreenState();
}

class _ProductItemScreenState extends State<ProductItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final double height = window.physicalSize.height;

  int? _quantity;
  String? _categoryUid;
  DateTime? _expirationDate;
  String? _qrCode;
  TextEditingController _expirationDateController = TextEditingController();
  Map<String, Category> _categoriesMap = Map();

  @override
  Widget build(BuildContext context) {
    if (_categoryUid == null) {
      _categoryUid = widget.product.category;
    }

    if (_expirationDate == null && widget.product.expirationDate != null) {
      _expirationDateController.text = widget.product.expirationDateFull!;
      _expirationDate = widget.product.expirationDateObject;
      _quantity = widget.product.quantity;
    }

    return _buildPageBody(context);
  }

  Widget _buildPageBody(BuildContext context) {
    final service = Provider.of<CategoryNotifier>(context);
    _categoriesMap = service.categories;
    return LoadingOverlay(
      child: _buildSafeArea(context),
      isLoading: service.isLoading,
    );
  }

  Widget _buildSafeArea(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 16, left: 24.0, right: 24.0, bottom: 32),
      child: Card(
          elevation: 5,
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ArgonColors.shape_radius),
          ),
          child: Column(
            children: [_buildPageTitle(context), _buildForm(context)],
          )),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Container(
          //height: MediaQuery.of(context).size.height * 0.63,
          //color: Color.fromRGBO(244, 245, 247, 1),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //_buildFormLegend(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategory(),
                      _buildQuantity(),
                      _buildDatePicker(context),
                    ],
                  ),
                  //SizedBox(height: 100),
                  _buildFormButtons(context)
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildFormLegend() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
      child: Center(
        child: Text(Labels.of(context).getMessage("signin_subtitle"),
            style: TextStyle(
                color: ArgonColors.text,
                fontWeight: FontWeight.w200,
                fontSize: 16)),
      ),
    );
  }

  Widget _buildCategory() {
    final labels = Labels.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownSearch<Category>(
        mode: Mode.MENU,
        dialogMaxWidth: 200,
        maxHeight: 266,
        items: _categoriesMap.values.toList(),
        selectedItem: widget.product.category != null
            ? _categoriesMap[widget.product.category]
            : null,
        showSearchBox: true,
        dropdownSearchDecoration:
            InputDecoration(labelText: labels.getMessage("category_label")),
        onChanged: (value) => setState(() => _categoryUid = value?.id),
        validator: (value) => Validator<Category>(context, value)
            .mandatory(msg: "category_mandatory")
            .validate(),
      ),
    );
  }

  Widget _buildQrCode() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormInput(
        //initialValue: widget.toEdit != null ? widget.toEdit!.name : null,
        onChanged: (value) => setState(() => _qrCode = value),
        placeholder: "product_name",
        maxLength: 32,
        keyboardType: TextInputType.name,
        prefixIcon: Icon(Icons.ac_unit_outlined),
        validator: (value) => Validator<String>(context, value)
            .mandatory(msg: 'mandatory_name')
            .validate(),
      ),
    );
  }

  Widget _buildQuantity() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormInput(
        initialValue: widget.product.quantity == null
            ? null
            : widget.product.quantity.toString(),
        onChanged: (value) => setState(() => _quantity = int.tryParse(value)),
        placeholder: Labels.of(context).getMessage('quantity_label'),
        keyboardType: TextInputType.number,
        prefixIcon: Icon(Icons.format_list_numbered),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        validator: (value) => Validator<String>(context, value)
            .mandatory(msg: 'quantity_mandatory')
            .validate(),
      ),
    );
  }

  Widget _wrapField({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return _wrapField(
      child: FormInput(
        controller: _expirationDateController,
        placeholder: Labels.of(context).getMessage('expiration_date_label'),
        keyboardType: TextInputType.datetime,
        readOnly: true,
        prefixIcon: Icon(Icons.date_range_rounded),
        onTap: () {
          Picker(
              hideHeader: true,
              backgroundColor: Colors.white,
              containerColor: Colors.white,
              adapter: DateTimePickerAdapter(
                value: widget.product.expirationDateObject ?? DateTime.now(),
              ),
              title:
                  Text(Labels.of(context).getMessage('expiration_date_label')),
              selectedTextStyle: TextStyle(color: Colors.blue),
              onConfirm: (Picker picker, List value) {
                setState(() {
                  _expirationDate =
                      (picker.adapter as DateTimePickerAdapter).value;

                  if (_expirationDate != null)
                    _expirationDateController.text =
                        ProductItem.full_date_formater.format(_expirationDate!);
                });
              }).showDialog(context);
        },
        validator: (value) => Validator<String>(context, value)
            .mandatory(msg: 'expiration_date_mandatory')
            .validate(),
      ),
    );
  }

  Padding _buildFormButtons(BuildContext context) {
    final notifier = Provider.of<ProductItemNotifier>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button.secondary(
              keyMessage: "cancel_label",
              onPressed: () => Navigator.of(context).pop(),
            ),
            SizedBox(
              width: 10,
            ),
            Button.primary(
              keyMessage: "save_label",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.product.category = _categoryUid!;
                  widget.product.expirationDate =
                      ProductItem.db_date_formater.format(_expirationDate!);

                  widget.product.quantity = _quantity!;
                  widget.product.cupboardUid = widget.cupboardUid;

                  if (widget.product.id == null) {
                    notifier.add(widget.product);
                  } else {
                    notifier.update(widget.product);
                  }

                  Navigator.of(context)
                      .pushReplacementNamed("/inventory/${widget.cupboardUid}");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageTitle(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(width: 0.5, color: ArgonColors.muted),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(widget.product.name, style: ArgonColors.titleWhite),
              ),
            ),
          ],
        ));
  }
}
