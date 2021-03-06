import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/like_review_delete_cubit/like_review_delete_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/models/review.dart';
import 'package:tawfeer/src/business_logic/models/user.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/ui/components/loading_dialog.dart';
import 'package:tawfeer/src/ui/components/product_loading_shimmer.dart';
import 'package:tawfeer/src/ui/components/reviews_list_view.dart';
import 'package:tawfeer/src/ui/components/rounded_button.dart';
import 'package:tawfeer/src/ui/components/user_msg.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final TextEditingController _commentTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // To avoid overflow when showing the screen while
      // the keyboard isn't closed.
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),
      body: Builder(
        builder: (context) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              return BlocProvider.of<ProductCubit>(context).fetchData(id: id);
            },
            edgeOffset: Scaffold.of(context).appBarMaxHeight ?? 50,
            displacement: 30,
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductInitial) {
                  return const ProductLoadingShimmer();
                  /*
                  return Padding(
                    padding: EdgeInsets.only(
                      top: Scaffold.of(context).appBarMaxHeight ?? 80,
                    ),
                    child: const ProductLoading(),
                  );
                  */
                }
                if (state is ProductFailure) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: Scaffold.of(context).appBarMaxHeight ?? 80,
                    ),
                    child: UserMsg(
                      text: state.exception.message + ', swipe to refresh..',
                      imgUrl: 'assets/images/error404.png',
                    ),
                  );
                }
                // ProductSuccess.
                return ScrollConfiguration(
                  behavior: NonGlowScrollBehavior(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      // So I can add a SingleChildScrollView even though I have an
                      // Expanded widget.
                      height: MediaQuery.of(context).size.height,
                      child: DefaultTabController(
                        length: 3,
                        child: BlocListener<LikeReviewDeleteCubit, LikeReviewDeleteState>(
                          listener: (context, state) {
                            if (state is LikeReviewDeleteLoading) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const LoadingDialog();
                                },
                              );
                            } else if (state is LikeReviewSuccess) {
                              _refreshIndicatorKey.currentState?.show();
                            }
                            else if(state is DeleteProductSuccess) {
                              Navigator.pop(context);
                              Navigator.pop(context, true);
                            }
                            else if (state is LikeReviewDeleteFailure) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text((state.exception.toString() + '.'))),
                              );
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _productImage(
                                context,
                                (state as ProductSuccess).product,
                              ),
                              const SizedBox(height: 20),
                              _titleRow(context, state.product),
                              const SizedBox(height: 10),
                              const TabBar(
                                labelColor: Colors.black,
                                tabs: [
                                  Tab(text: 'Details'),
                                  Tab(text: 'Description'),
                                  Tab(text: 'Reviews'),
                                ],
                              ),
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: NonGlowScrollBehavior(),
                                  child: TabBarView(
                                    children: [
                                      SingleChildScrollView(
                                        child: _detailsRow(
                                          context,
                                          state.product,
                                          state.owner,
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 12),
                                            _descriptionText(
                                              context,
                                              state.product,
                                            ),
                                            const SizedBox(height: 12),
                                          ],
                                        ),
                                      ),
                                      _reviewsColumn(context, state.reviews),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      // Colors.transparent
      backgroundColor: Colors.black.withOpacity(0.3),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_rounded),
        splashRadius: 20.0,
      ),
      actions: [
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductSuccess &&
                state.product.ownerId == Shared.myUser!.id) {
              return IconButton(
                onPressed: () {
                  _showMenu(context, state.product);
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: MyColors.white,
                ),
                splashRadius: 20.0,
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _productImage(BuildContext context, Product product) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.2,
      width: double.infinity,
      color: MyColors.white,
      child: product.imgUrl != null
          ? Image.network(
              Shared.baseURL + '/' + product.imgUrl!,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 50.0, left: 50, right: 50, top: 100),
                  child: Image.asset(
                    'assets/images/tawfeer.png',
                    fit: BoxFit.contain,
                    height: 50,
                    width: 50,
                  ),
                );
              },
            )
          : Padding(
              padding: const EdgeInsets.only(
                  bottom: 50.0, left: 50, right: 50, top: 100),
              child: Image.asset(
                'assets/images/tawfeer.png',
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
            ),
    );
  }

  Widget _titleRow(BuildContext context, Product product) {
    return Row(
      children: [
        Expanded(
          child: _titlePriceColumn(context, product),
        ),
        const SizedBox(width: 20),
        RoundedButton(
          onTap: () {
            if (product.liked!) {
              BlocProvider.of<LikeReviewDeleteCubit>(context).removeLike(id: id);
            } else {
              BlocProvider.of<LikeReviewDeleteCubit>(context).addLike(id: id);
            }
          },
          icon: product.liked! ? Icons.favorite : Icons.favorite_border_rounded,
          counter: product.likes,
          iconColor: product.liked! ? MyColors.red : Colors.black,
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _titlePriceColumn(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.productTitle,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              Text(
                "\$${product.newPrice.toString()}",
                style: const TextStyle(
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 20),
              if (product.newPrice != product.oldPrice)
                Text(
                  "\$${product.oldPrice.toString()}",
                  style: const TextStyle(
                    color: MyColors.darkGrey,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _descriptionText(BuildContext context, Product product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 20.0),
        Expanded(
          child: Text(product.description),
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }

  Widget _detailsRow(BuildContext context, Product product, User owner) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          _keysColumn(context, product),
          const SizedBox(width: 15),
          Expanded(
            child: _valuesColumn(context, product, owner),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _keysColumn(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        const SizedBox(height: 16),
        const Text(
          'Quantity:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        const SizedBox(height: 16),
        if (product.discount != 0)
          const Text(
            'Discount:',
            style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
          ),
        if (product.discount != 0) const SizedBox(height: 16),
        const Text(
          'Expire Date:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        const SizedBox(height: 16),
        const Text(
          'Phone Number:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        const SizedBox(height: 16),
        const Text(
          'Email:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
      ],
    );
  }

  Widget _valuesColumn(
    BuildContext context,
    Product product,
    User owner,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.category,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Text(
          product.quantity.toString(),
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        if (product.discount != 0)
          Text(
            "${product.discount.toString()}%",
            style: const TextStyle(fontSize: 14),
          ),
        if (product.discount != 0) const SizedBox(height: 16),
        Text(
          DateFormat.yMMMd().format(product.expireDate),
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Text(
          '+963' + owner.phoneNumber.toString(),
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Text(
          owner.email,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  void _showMenu(BuildContext context, Product product) {
    showMenu<int>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      position: const RelativeRect.fromLTRB(20.0, 0.0, 0.0, 0.0),
      items: [
        _popMenuItem(context, 'Edit', 0, Icons.edit, Colors.black),
        _popMenuItem(context, 'Delete', 1, Icons.delete_rounded, MyColors.red),
      ],
    ).then(
      (int? value) {
        if (value == null) return;
        if (value == 0) {
          Navigator.pushNamed(context, '/edit_product', arguments: product)
              .then(
            (dynamic value) {
              if (value == true) {
                _refreshIndicatorKey.currentState?.show();
                Shared.homeRefreshIndicatorKey?.currentState?.show();
                Shared.myProductsRefreshIndicatorKey?.currentState?.show();
              }
            },
          );
        }
        if (value == 1) {
          LikeReviewDeleteCubit cubit = BlocProvider.of<LikeReviewDeleteCubit>(context);
          showDialog(
            context: context,
            builder: (context) => _deleteDialog(
              context,
              cubit,
            ),
          );
        }
      },
    );
  }

  PopupMenuItem<int> _popMenuItem(
    BuildContext context,
    String text,
    int value,
    IconData icon,
    Color color,
  ) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog _deleteDialog(BuildContext context, LikeReviewDeleteCubit cubit) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      title: const Text(
        'Are You Sure?',
        style: TextStyle(fontSize: 17),
      ),
      content: const Text(
        'This product will be deleted permanently.',
        style: TextStyle(fontSize: 15),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            cubit.deleteProduct(id: id);
          },
          style: TextButton.styleFrom(
            primary: MyColors.red,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }

  Widget _reviewsColumn(BuildContext context, List<Review> list) {
    return Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: NonGlowScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ReviewsListView(list: list),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 1,
          color: MyColors.lightGrey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _textField(context),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _textField(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: _commentTextEditingController,
        textCapitalization: TextCapitalization.sentences,
        cursorRadius: const Radius.circular(7.0),
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Write a review..',
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: MyColors.primaryColor,
            ),
          ),
          hintStyle: const TextStyle(fontSize: 14),
          suffixIcon: IconButton(
            onPressed: () {
              if (_commentTextEditingController.text.isNotEmpty) {
                BlocProvider.of<LikeReviewDeleteCubit>(context).addReview(
                  comment: _commentTextEditingController.text,
                  id: id,
                );
                _commentTextEditingController.clear();
              }
            },
            icon: const Icon(
              Icons.send_rounded,
              color: MyColors.primaryColor,
              size: 21,
            ),
            splashRadius: 20.0,
          ),
        ),
      ),
    );
  }
}
