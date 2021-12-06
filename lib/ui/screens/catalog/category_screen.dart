import 'package:cupboard/ui/dialogs/confirm_dialog.dart';
import 'package:cupboard/ui/widgets/localization_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:cupboard/locale/labels.dart';
import 'package:cupboard/constants/Theme.dart';
import 'package:cupboard/constants/validators.dart';

import 'package:cupboard/domain/entities/category.dart';
import 'package:cupboard/domain/notifiers/notifiers.dart';

import 'package:cupboard/widgets/form-input.dart';
import 'package:cupboard/widgets/button.dart';
import 'package:cupboard/ui/widgets/empty_background.dart';

class CategoriesScreen extends StatefulWidget {
  final String cupboardUid;

  const CategoriesScreen({Key? key, required this.cupboardUid})
      : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? _searchName;
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = true;
  Map<String, Category> _filteredCategories = Map();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = Provider.of<CategoryNotifier>(context);
    _isLoading = state.isLoading;

    if (!_isLoading) {
      _filteredCategories = state.filteredCategories;
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
    return LoadingOverlay(
      isLoading: _isLoading,
      child: _buildBody(context, _filteredCategories.values.toList()),
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
    if (categories.isEmpty)
      return Expanded(child: EmptyBackground(keyMessage: "empty_cupboard"));

    return Expanded(
      child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final category = categories[index];

            return Card(
              margin: EdgeInsets.all(1.0),
              color: Colors.transparent,
              child: _buildCategoryTitle(context, category),
            );
          }),
    );
  }

  Widget _buildCategoryTitle(BuildContext context, Category category) {
    final lb = Labels.of(context);
    final state = Provider.of<CategoryNotifier>(context, listen: false);

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
                child: Text("${category.name}",
                    style: ArgonColors.expandedTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () =>
                      _buildNewCategoryDialog(context, category).show(),
                  tooltip: lb.getMessage("edit_label_general"),
                  icon: Icon(Icons.edit_outlined),
                ),
                IconButton(
                  onPressed: () {
                    ConfirmDialog.question(
                      context,
                      keyMessage: "delete_confirm",
                      args: [category.name],
                      btnOkOnPress: () => state.delete(category),
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
              Provider.of<CategoryNotifier>(context, listen: false)
                  .filter(_searchName);
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
              Provider.of<CategoryNotifier>(context, listen: false)
                  .filter(_searchName);
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
          onTap: () => _buildNewCategoryDialog(context).show(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.add, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LocaleText.subtitle("new_category"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AwesomeDialog _buildNewCategoryDialog(BuildContext context,
      [Category? toEdit]) {
    final CategoryNotifier notifier =
        Provider.of<CategoryNotifier>(context, listen: false);

    return AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width * (kIsWeb ? 0.35 : 0.75),
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      dialogBackgroundColor: Colors.grey,
      body: _NewCategoryForm(
        service: notifier,
        cupboardUid: widget.cupboardUid,
        toEdit: toEdit,
      ),
    );
  }
}

class _NewCategoryForm extends StatefulWidget {
  final CategoryNotifier service;
  final Category? toEdit;
  final String cupboardUid;

  const _NewCategoryForm({
    Key? key,
    required this.service,
    required this.cupboardUid,
    this.toEdit,
  }) : super(key: key);

  @override
  _NewCategoryFormState createState() => _NewCategoryFormState();
}

class _NewCategoryFormState extends State<_NewCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTitle(context),
          _buildTextName(context),
          _buildFormButtons(context)
        ],
      ),
    );
  }

  Widget _buildFormTitle(BuildContext context) {
    //widget.toEdit != null
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Center(
        child: LocaleText.title(
            widget.toEdit != null ? "edit_category" : "new_category"),
      ),
    );
  }

  Widget _buildTextName(BuildContext context) {
    return _buildInputWrapper(FormInput(
      onChanged: (value) => setState(() => _name = value),
      initialValue: widget.toEdit != null ? widget.toEdit!.name : null,
      placeholder: Labels.of(context).getMessage('category_name'),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      prefixIcon: Icon(Icons.category_rounded),
      maxLength: 32,
      validator: (value) => Validator<String>(context, value)
          .mandatory(msg: 'mandatory_name')
          .length(min: 4, max: 32)
          .validate(),
    ));
  }

  Widget _buildInputWrapper(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }

  Widget _buildFormButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                  if (widget.toEdit == null) {
                    Category newCategory = Category(
                      name: _name!,
                      cupboardUid: widget.cupboardUid,
                    );
                    widget.service.addCategory(newCategory);
                  } else {
                    widget.toEdit!.name = _name!;
                    widget.service.update(widget.toEdit!);
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
