import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/constants/validators.dart';
import 'package:cupboard/data/injectors/dependency_injector.dart';
import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/entities/product.dart';
import 'package:cupboard/domain/entities/product_item.dart';
import 'package:cupboard/domain/notifiers/notifiers.dart';
import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/ui/dialogs/confirm_dialog.dart';
import 'package:cupboard/ui/screens/product_item/product_item_screen.dart';
import 'package:cupboard/ui/widgets/empty_background.dart';
import 'package:cupboard/ui/widgets/localization_text.dart';
import 'package:cupboard/widgets/button.dart';
import 'package:cupboard/widgets/form-input.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cupboard/data/repositories/repositories.dart';

class ProductsScreen extends StatefulWidget {
  final String cupboardUid;

  const ProductsScreen({Key? key, required this.cupboardUid}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String? _searchName;
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  Map<String, List<Product>> _filteredProductsMap = Map();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = Provider.of<ProductNotifier>(context);
    _isLoading = state.isLoading;

    if (!_isLoading) {
      _filteredProductsMap = state.filteredProductsMap;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildSafeArea(context);
  }

  Widget _buildSafeArea(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: _buildLoadingBody(context),
      ),
    );
  }

  Widget _buildLoadingBody(BuildContext context) {
    final notifier = Provider.of<CategoryNotifier>(context);
    final categories = notifier.categories.values.toList();

    return LoadingOverlay(
      isLoading: notifier.isLoading || _isLoading,
      child: _buildBody(context, categories),
    );
  }

  Widget _buildBody(BuildContext context, List<Category> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPageTitle(context),
        _buildBodyList(categories),
        _buildAddCategoryTitle(context),
      ],
    );
  }

  Widget _buildBodyList(List<Category> categories) {
    if (_filteredProductsMap.isEmpty)
      return Expanded(child: EmptyBackground(keyMessage: "empty_cupboard"));

    return Expanded(
      child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryTile(category);
          }),
    );
  }

  Widget _buildCategoryTile(Category category) {
    if (_filteredProductsMap[category.id] == null)
      return const SizedBox.shrink();

    return ExpansionTile(
      title: _buildTitleTile(category),
      initiallyExpanded: true,
      children: [
        _buildProductList(_filteredProductsMap[category.id]!),
      ],
    );
  }

  Widget _buildTitleTile(Category category) {
    final lb = Labels.of(context);
    final productList = _filteredProductsMap[category.id];

    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: Container(
                child: Text("${category.name}",
                    style: ArgonColors.expandedTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              productList == null
                  ? lb.getMessage("empty_label")
                  : lb.getMessage("count_item_label", [productList.length]),
              style: ArgonColors.expandedSubTitle,
            ),
          ),

          //VerticalDivider(),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
        itemCount: products.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: EdgeInsets.all(1.0),
            color: Colors.transparent,
            child: _buildProductTitle(context, product),
          );
        });
  }

  Widget _buildProductTitle(BuildContext context, Product product) {
    final lb = Labels.of(context);
    final state = Provider.of<ProductNotifier>(context, listen: false);

    return Container(
      height: 45,
      width: double.infinity,
      padding: EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Container(
                child: Text("${product.name}",
                    style: ArgonColors.titleCardWhite,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _buildNewProductDialog(product).show(),
                  tooltip: lb.getMessage("edit_label_general"),
                  icon: Icon(Icons.edit_outlined),
                ),
                IconButton(
                  onPressed: () {
                    ConfirmDialog.question(
                      context,
                      keyMessage: "delete_confirm",
                      args: [product.name],
                      btnOkOnPress: () => state.delete(product),
                    ).build().show();
                  },
                  tooltip: lb.getMessage("delete_label_general"),
                  icon: Icon(Icons.delete_outline_rounded,
                      color: Colors.redAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageTitle(BuildContext context) {
    final lb = Labels.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_buildSearchBar(lb)],
        ),
      ),
    );
  }

  Widget _buildSearchBar(Labels lb) {
    return Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: Container(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              suffixIcon: _buildSearchIconButton(),
              hintText: lb.getMessage("search_label"),
            ),
            onChanged: (String? value) {
              setState(() {
                _searchName = value;
              });
              Provider.of<ProductNotifier>(context, listen: false)
                  .filterProducts(_searchName);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchIconButton() {
    return _searchName != null && _searchName!.length > 0
        ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                _searchName = null;
                _searchController.clear();
              });
              Provider.of<ProductNotifier>(context, listen: false)
                  .filterProducts(_searchName);
            },
          )
        : Icon(Icons.search_outlined);
  }

  Widget _buildAddCategoryTitle(BuildContext context) {
    return Container(
      height: 45,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _buildNewProductDialog().show(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.add, color: Colors.white),
              LocaleText.subtitle(
                "new_product",
                padding: const EdgeInsets.all(8.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AwesomeDialog _buildNewProductDialog([Product? toEdit]) {
    final productState = Provider.of<ProductNotifier>(context, listen: false);
    final categoryState = Provider.of<CategoryNotifier>(context, listen: false);

    return AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width * (kIsWeb ? 0.35 : 0.75),
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      dialogBackgroundColor: Colors.grey,
      body: _FormProduct(
        categoryState: categoryState,
        productState: productState,
        cupboardUid: widget.cupboardUid,
        toEdit: toEdit,
      ),
    );
  }
}

class _FormProduct extends StatefulWidget {
  final CategoryNotifier categoryState;
  final ProductNotifier productState;
  final Product? toEdit;
  final String cupboardUid;

  _FormProduct(
      {Key? key,
      required this.categoryState,
      required this.productState,
      this.toEdit,
      required this.cupboardUid})
      : super(key: key);

  @override
  __FormProductState createState() => __FormProductState();
}

class __FormProductState extends State<_FormProduct> {
  final _formKey = GlobalKey<FormState>();
  String? _categoryUid;
  String? _name;

  @override
  Widget build(BuildContext context) {
    if (_categoryUid == null && widget.toEdit != null) {
      _categoryUid = widget.toEdit!.category;
    }

    return _buildForm();
  }

  Widget _buildForm() {
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
                      _buildFormTitle(),
                      _buildName(),
                      _buildCategory(),
                    ],
                  ),
                  _buildFormButtons(context)
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildFormTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Center(
        child: LocaleText.title(
            widget.toEdit != null ? "edit_product" : "new_product"),
      ),
    );
  }

  Widget _buildCategory() {
    final labels = Labels.of(context);
    final categories = widget.categoryState.categories;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownSearch<Category>(
        mode: Mode.DIALOG,
        dialogMaxWidth: 200,
        items: categories.values.toList(),
        selectedItem: (widget.toEdit != null && widget.toEdit!.category != null)
            ? categories[widget.toEdit!.category]
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

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormInput(
        initialValue: widget.toEdit != null ? widget.toEdit!.name : null,
        onChanged: (value) => setState(() => _name = value),
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

  Widget _buildFormButtons(BuildContext context) {
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
                  if (widget.toEdit != null) {
                    widget.toEdit!.category = _categoryUid!;
                    widget.toEdit!.name = _name!;
                    widget.productState.update(widget.toEdit!);
                  } else {
                    final newProduct = Product(
                      name: _name!,
                      category: _categoryUid!,
                      cupboardUid: widget.cupboardUid,
                    );
                    widget.productState.add(newProduct);
                  }

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
