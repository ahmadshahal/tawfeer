import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/components/my_material_button.dart';
import 'package:tawfeer/src/ui/components/my_text_form_field.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

const String titleKey = 'title';
const String categoryKey = 'category';
const String quantityKey = 'quantity';
const String expireDateKey = 'expireDate';
const String priceKey = 'price';
const String firstDiscountDateKey = 'firstDiscountDate';
const String firstDiscountKey = 'firstDiscount';
const String secondDiscountDateKey = 'secondDiscountDate';
const String secondDiscountKey = 'secondDiscount';
const String thirdDiscountDateKey = 'thirdDiscountDate';
const String thirdDiscountKey = 'thirdDiscount';
const String descriptionKey = 'description';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  final Map<String, TextEditingController> _controllers = {
    titleKey: TextEditingController(),
    categoryKey: TextEditingController(),
    quantityKey: TextEditingController(),
    expireDateKey: TextEditingController(),
    priceKey: TextEditingController(),
    firstDiscountDateKey: TextEditingController(),
    firstDiscountKey: TextEditingController(),
    secondDiscountDateKey: TextEditingController(),
    secondDiscountKey: TextEditingController(),
    thirdDiscountDateKey: TextEditingController(),
    thirdDiscountKey: TextEditingController(),
    descriptionKey: TextEditingController(),
  };

  // TODO: Add validators.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: ScrollConfiguration(
        behavior: NonGlowScrollBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                _productImage(context),
                const SizedBox(height: 40),
                _titleField(),
                const SizedBox(height: 20),
                _categoryQuantityRow(context),
                const SizedBox(height: 20),
                _expireDatePrice(context),
                const SizedBox(height: 20),
                _discountDatesColumn(context),
                const SizedBox(height: 20),
                _descriptionField(context),
                const SizedBox(height: 20),
                MyMaterialButton(
                  text: 'Done',
                  callBack: () {},
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 2.0,
      backgroundColor: MyColors.secondaryColor,
      title: const Text(
        'Add Product',
        style: TextStyle(
          fontSize: 17.0,
          color: MyColors.white,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_rounded),
        splashRadius: 20.0,
      ),
    );
  }

  Widget _productImage(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: MyColors.lightGrey,
      ),
      child: const Icon(
        Icons.add_a_photo_rounded,
        size: 35,
        color: MyColors.darkGrey,
      ),
    );
  }

  Widget _titleField() {
    return MyTextFormField(
      label: 'Title',
      textController: _controllers[titleKey]!,
      textInputType: TextInputType.text,
    );
  }

  Widget _categoryQuantityRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: MyTextFormField(
            label: 'Category',
            textController: _controllers[categoryKey]!,
            textInputType: TextInputType.text,
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          flex: 1,
          child: MyTextFormField(
            label: 'Quantity',
            textController: _controllers[quantityKey]!,
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _expireDatePrice(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // TODO: Show date picker.
          flex: 2,
          child: MyTextFormField(
            label: 'Expire Date',
            textController: _controllers[expireDateKey]!,
            textInputType: TextInputType.text,
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          flex: 1,
          child: MyTextFormField(
            label: 'Price',
            textController: _controllers[priceKey]!,
            prefixText: '\$',
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _discountDatesColumn(BuildContext context) {
    return Column(
      children: [
        _discountDateRow(
          context,
          _controllers[firstDiscountDateKey]!,
          _controllers[firstDiscountKey]!,
        ),
        const SizedBox(height: 20),
        _discountDateRow(
          context,
          _controllers[secondDiscountDateKey]!,
          _controllers[secondDiscountKey]!,
        ),
        const SizedBox(height: 20),
        _discountDateRow(
          context,
          _controllers[thirdDiscountDateKey]!,
          _controllers[thirdDiscountKey]!,
        ),
      ],
    );
  }

  Widget _discountDateRow(
      BuildContext context,
      TextEditingController dateController,
      TextEditingController discountController) {
    return Row(
      children: [
        Expanded(
          // TODO: Show date picker.
          flex: 2,
          child: MyTextFormField(
            label: 'Discount Start Date',
            textController: dateController,
            textInputType: TextInputType.text,
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          flex: 1,
          child: MyTextFormField(
            label: 'Discount',
            prefixText: '%',
            textController: discountController,
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _descriptionField(BuildContext context) {
    return MyTextFormField(
      label: 'Description',
      textController: _controllers[descriptionKey]!,
      textInputType: TextInputType.text,
    );
  }
}
