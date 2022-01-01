import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/add_product_cubit/add_product_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/expire_date_field_cubit/expire_date_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/image_picker_cubit/image_picker_cubit.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/business_logic/utils/validation_utility.dart';
import 'package:tawfeer/src/ui/components/loading_dialog.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                const SizedBox(height: 30),
                _productImage(context),
                const SizedBox(height: 30),
                BlocListener<AddProductCubit, AddProductState>(
                  listener: (context, state) {
                    if (state is AddProductSubmitting) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const LoadingDialog();
                        },
                      );
                    } else if (state is AddProductSuccess) {
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    } else if (state is AddProductFailure) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text((state.exception.toString()))),
                      );
                    }
                  },
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _titleField(),
                        const SizedBox(height: 20),
                        _categoryQuantityRow(context),
                        const SizedBox(height: 20),
                        _expireDatePriceRow(context),
                        const SizedBox(height: 20),
                        _discountDatesColumn(context),
                        const SizedBox(height: 20),
                        _descriptionField(context),
                        const SizedBox(height: 20),
                        MyMaterialButton(
                          text: 'Done',
                          callBack: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AddProductCubit>(context).submit(
                                product: Product.special(
                                  productTitle: _controllers[titleKey]!.text,
                                  ownerId: Shared.myUser!.id,
                                  description: _controllers[descriptionKey]!.text,
                                  category: _controllers[categoryKey]!.text,
                                  oldPrice: _controllers[priceKey]!.text,
                                  quantity: _controllers[quantityKey]!.text,
                                  expireDate: _controllers[expireDateKey]!.text,
                                  firstDiscountDate: _controllers[firstDiscountDateKey]!.text,
                                  firstDiscount: _controllers[firstDiscountKey]!.text,
                                  secondDiscountDate: _controllers[secondDiscountDateKey]!.text,
                                  secondDiscount: _controllers[secondDiscountKey]!.text,
                                  thirdDiscountDate: _controllers[thirdDiscountDateKey]!.text,
                                  thirdDiscount: _controllers[thirdDiscountKey]!.text,
                                  xFile: BlocProvider.of<ImagePickerCubit>(context).file,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
    return GestureDetector(
      onTap: () {
        _showBottomSheet(
          context: context,
          cameraCallBack: () {
            BlocProvider.of<ImagePickerCubit>(context)
                .pickImage(ImageSource.camera);
          },
          galleryCallBack: () {
            BlocProvider.of<ImagePickerCubit>(context)
                .pickImage(ImageSource.gallery);
          },
        );
      },
      child: Container(
        width: 170,
        height: 170,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: MyColors.lightGrey,
        ),
        child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
          builder: (context, state) {
            if (state is ImagePickerSuccess) {
              return Image(
                image: FileImage(File(state.imagePath)),
                fit: BoxFit.cover,
              );
            } else {
              return const Icon(
                Icons.add_a_photo_rounded,
                size: 35,
                color: MyColors.darkGrey,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _titleField() {
    return MyTextFormField(
      label: 'Title',
      validate: (String? value) {
        return ValidationUtility.validateProductTitle(value ?? "");
      },
      textController: _controllers[titleKey]!,
      textInputType: TextInputType.text,
    );
  }

  Widget _categoryQuantityRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: MyTextFormField(
            label: 'Category',
            validate: (String? value) {
              return ValidationUtility.validateProductCategory(value ?? "");
            },
            textController: _controllers[categoryKey]!,
            hint: 'Food, Drinks, etc..',
            textInputType: TextInputType.text,
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          flex: 1,
          child: MyTextFormField(
            label: 'Quantity',
            validate: (String? value) {
              return ValidationUtility.validateNumericField(value ?? "");
            },
            textController: _controllers[quantityKey]!,
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _expireDatePriceRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: MyTextFormField(
            onTap: () {
              _showExpireDatePicker(context);
            },
            validate: (String? value) {
              return ValidationUtility.validateDate(value ?? "");
            },
            label: 'Expire Date',
            textController: _controllers[expireDateKey]!,
            textInputType: TextInputType.text,
            readOnly: true,
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          flex: 1,
          child: MyTextFormField(
            label: 'Price',
            validate: (String? value) {
              return ValidationUtility.validateNumericField(value ?? "");
            },
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
          context: context,
          dateController: _controllers[firstDiscountDateKey]!,
          discountController: _controllers[firstDiscountKey]!,
          validateDate: (String? value) {
            if (_controllers[firstDiscountKey]!.text.isEmpty) {
              return null;
            } else {
              return ValidationUtility.validateDate(value ?? "");
            }
          },
          validateDiscount: (String? value) {
            if (_controllers[firstDiscountDateKey]!.text.isEmpty) {
              return null;
            } else {
              return ValidationUtility.validateNumericField(value ?? "");
            }
          },
        ),
        const SizedBox(height: 20),
        _discountDateRow(
          context: context,
          dateController: _controllers[secondDiscountDateKey]!,
          discountController: _controllers[secondDiscountKey]!,
          validateDate: (String? value) {
            if (_controllers[secondDiscountKey]!.text.isEmpty) {
              return null;
            } else {
              return ValidationUtility.validateDate(value ?? "");
            }
          },
          validateDiscount: (String? value) {
            if (_controllers[secondDiscountDateKey]!.text.isEmpty) {
              return null;
            } else {
              return ValidationUtility.validateNumericField(value ?? "");
            }
          },
        ),
        const SizedBox(height: 20),
        _discountDateRow(
          context: context,
          dateController: _controllers[thirdDiscountDateKey]!,
          discountController: _controllers[thirdDiscountKey]!,
          validateDate: (String? value) {
            if (_controllers[thirdDiscountKey]!.text.isEmpty) {
              return null;
            } else {
              return ValidationUtility.validateDate(value ?? "");
            }
          },
          validateDiscount: (String? value) {
            if (_controllers[thirdDiscountDateKey]!.text.isEmpty) {
              return null;
            } else {
              return ValidationUtility.validateNumericField(value ?? "");
            }
          },
        ),
      ],
    );
  }

  Widget _discountDateRow({
    required BuildContext context,
    required TextEditingController dateController,
    required TextEditingController discountController,
    required FormFieldValidator<String>? validateDate,
    required FormFieldValidator<String>? validateDiscount,
  }) {
    return BlocBuilder<ExpireDateCubit, bool>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: MyTextFormField(
                label: 'Discount Start Date',
                textController: dateController,
                readOnly: true,
                enabled: state,
                validate: validateDate,
                textColor: state ? MyColors.darkGrey : Colors.grey[500],
                onTap: () {
                  _showDatePicker(
                    context,
                    dateController,
                    DateFormat.yMMMd().parse(_controllers[expireDateKey]!.text),
                  );
                },
                textInputType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              flex: 1,
              child: MyTextFormField(
                label: 'Discount',
                prefixText: '%',
                enabled: state,
                validate: validateDiscount,
                textColor: state ? MyColors.darkGrey : Colors.grey[500],
                textController: discountController,
                textInputType: TextInputType.number,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _descriptionField(BuildContext context) {
    return DescriptionTextFormField(
      label: 'Description',
      textController: _controllers[descriptionKey]!,
    );
  }

  void _showDatePicker(
    BuildContext context,
    TextEditingController controller,
    DateTime lastDate,
  ) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: lastDate,
    ).then(
      (DateTime? value) {
        if (value == null) return;
        controller.text = DateFormat.yMMMd().format(value);
      },
    );
  }

  void _showExpireDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then(
      (DateTime? value) {
        if (value == null) return;
        _controllers[expireDateKey]!.text = DateFormat.yMMMd().format(value);
        BlocProvider.of<ExpireDateCubit>(context).expireDateFilled();
      },
    );
  }

  void _showBottomSheet({
    required BuildContext context,
    required Function cameraCallBack,
    required Function galleryCallBack,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('Gallery', style: TextStyle(fontSize: 15)),
              onTap: () {
                Navigator.pop(context);
                galleryCallBack();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera', style: TextStyle(fontSize: 15)),
              onTap: () {
                Navigator.pop(context);
                cameraCallBack();
              },
            ),
          ],
        );
      },
    );
  }
}
